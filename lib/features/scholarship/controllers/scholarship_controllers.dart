import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/scholarship.dart';

/// Controller for managing scholarships.
class ScholarshipController extends GetxController {
  static ScholarshipController get instance => Get.find();

  // Firebase reference
  final _db = FirebaseFirestore.instance;

  // Observable scholarship list
  final RxList<Scholarship> scholarships = <Scholarship>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error state
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchScholarships();
  }

  /// Fetch all scholarships from Firestore.
  Future<void> fetchScholarships() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('scholarships').get();

      final List<Scholarship> scholarshipsList =
          snapshot.docs.map((doc) => Scholarship.fromFirestore(doc)).toList();

      scholarships.value = scholarshipsList;
    } catch (e) {
      errorMessage.value = 'Failed to fetch scholarships: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get filtered scholarships based on criteria.
  List<Scholarship> getFilteredScholarships({
    bool? meritBased,
    bool? needBased,
    double? minGpa,
    List<String>? categories,
  }) {
    return scholarships.where((scholarship) {
      // Filter by merit-based
      if (meritBased != null && scholarship.meritBased != meritBased) {
        return false;
      }

      // Filter by need-based
      if (needBased != null && scholarship.needBased != needBased) {
        return false;
      }

      // Filter by GPA requirement
      if (minGpa != null &&
          scholarship.requiredGpa != null &&
          scholarship.requiredGpa! > minGpa) {
        return false;
      }

      // Filter by categories
      if (categories != null && categories.isNotEmpty) {
        if (!scholarship.categories.any((cat) => categories.contains(cat))) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  /// Get a list of all scholarships for the UI.
  List<Scholarship> getScholarships() {
    // If scholarships haven't been fetched yet, return empty list
    if (scholarships.isEmpty && !isLoading.value) {
      fetchScholarships();
    }

    return scholarships;
  }

  /// Get a scholarship by ID.
  Future<Scholarship?> getScholarshipById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('scholarships').doc(id).get();

      if (doc.exists) {
        return Scholarship.fromFirestore(doc);
      }

      return null;
    } catch (e) {
      errorMessage.value = 'Failed to fetch scholarship: $e';
      return null;
    }
  }

  /// Search scholarships by keyword.
  List<Scholarship> searchScholarships(String keyword) {
    if (keyword.isEmpty) {
      return scholarships;
    }

    final String searchTerm = keyword.toLowerCase();

    return scholarships.where((scholarship) {
      return scholarship.title.toLowerCase().contains(searchTerm) ||
          scholarship.description.toLowerCase().contains(searchTerm) ||
          (scholarship.eligibility?.toLowerCase().contains(searchTerm) ??
              false) ||
          scholarship.categories
              .any((category) => category.toLowerCase().contains(searchTerm));
    }).toList();
  }

  /// Get the latest scholarships by scraped date.
  List<Scholarship> getLatestScholarships({int limit = 10}) {
    final List<Scholarship> sortedList = List<Scholarship>.from(scholarships);

    // Sort by scraped date (newest first)
    sortedList.sort((a, b) {
      if (a.scrapedDate == null && b.scrapedDate == null) return 0;
      if (a.scrapedDate == null) return 1;
      if (b.scrapedDate == null) return -1;
      return b.scrapedDate!.compareTo(a.scrapedDate!);
    });

    // Return up to the specified limit
    return sortedList.take(limit).toList();
  }
}
