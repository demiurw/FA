import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing a scholarship.
class Scholarship {
  final String id;
  final String title;
  final String description;
  final String amount;
  final String deadline;
  final String? eligibility;
  final String? applicationLink;
  final String sourceWebsite;
  final String sourceName;
  final bool meritBased;
  final bool needBased;
  final double? requiredGpa;
  final List<String> categories;
  final DateTime? scrapedDate;
  final DateTime? lastUpdated;

  /// Constructor for Scholarship model.
  Scholarship({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.deadline,
    this.eligibility,
    this.applicationLink,
    required this.sourceWebsite,
    required this.sourceName,
    required this.meritBased,
    required this.needBased,
    this.requiredGpa,
    required this.categories,
    this.scrapedDate,
    this.lastUpdated,
  });

  /// Create an empty scholarship.
  factory Scholarship.empty() => Scholarship(
        id: '',
        title: '',
        description: '',
        amount: '',
        deadline: '',
        sourceWebsite: '',
        sourceName: '',
        meritBased: false,
        needBased: false,
        categories: [],
      );

  /// Convert Firestore document to Scholarship object.
  factory Scholarship.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Scholarship(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      amount: data['amount'] ?? '',
      deadline: data['deadline'] ?? '',
      eligibility: data['eligibility'],
      applicationLink: data['application_link'],
      sourceWebsite: data['source_website'] ?? '',
      sourceName: data['source_name'] ?? '',
      meritBased: data['meritBased'] ?? false,
      needBased: data['needBased'] ?? false,
      requiredGpa: data['required_gpa'] != null
          ? (data['required_gpa'] as num).toDouble()
          : null,
      categories: List<String>.from(data['categories'] ?? []),
      scrapedDate: data['scraped_date'] != null
          ? (data['scraped_date'] as Timestamp).toDate()
          : null,
      lastUpdated: data['last_updated'] != null
          ? (data['last_updated'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert Scholarship object to a map for Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'deadline': deadline,
      'eligibility': eligibility,
      'application_link': applicationLink,
      'source_website': sourceWebsite,
      'source_name': sourceName,
      'meritBased': meritBased,
      'needBased': needBased,
      'required_gpa': requiredGpa,
      'categories': categories,
      'last_updated': FieldValue.serverTimestamp(),
    };
  }

  /// Create a copy of this Scholarship with given fields replaced with new values.
  Scholarship copyWith({
    String? id,
    String? title,
    String? description,
    String? amount,
    String? deadline,
    String? eligibility,
    String? applicationLink,
    String? sourceWebsite,
    String? sourceName,
    bool? meritBased,
    bool? needBased,
    double? requiredGpa,
    List<String>? categories,
    DateTime? scrapedDate,
    DateTime? lastUpdated,
  }) {
    return Scholarship(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      deadline: deadline ?? this.deadline,
      eligibility: eligibility ?? this.eligibility,
      applicationLink: applicationLink ?? this.applicationLink,
      sourceWebsite: sourceWebsite ?? this.sourceWebsite,
      sourceName: sourceName ?? this.sourceName,
      meritBased: meritBased ?? this.meritBased,
      needBased: needBased ?? this.needBased,
      requiredGpa: requiredGpa ?? this.requiredGpa,
      categories: categories ?? this.categories,
      scrapedDate: scrapedDate ?? this.scrapedDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
