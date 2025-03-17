import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_aid_project/utils/formatters/formatter.dart';

/// Model class representing admin data.
class AdminModel {
  final String? id;
  String username;
  String email;
  String? firstName;
  String? lastName;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;

  /// Constructor for AdminModel.
  AdminModel({
    this.id,
    required this.username,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.profilePicture = '',
    this.createdAt,
    this.updatedAt,
  });

  /// Helper methods
  String get fullName => '$firstName $lastName';
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Static function to create an empty admin model.
  static AdminModel empty() => AdminModel(username: '', email: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Email': email,
      'FirstName': firstName ?? '',
      'LastName': lastName ?? '',
      'ProfilePicture': profilePicture ?? '',
      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  /// Factory method to create an AdminModel from a Firebase document snapshot.
  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AdminModel(
        id: document.id,
        username: data.containsKey('Username') ? data['Username'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        createdAt: data.containsKey('CreatedAt')
            ? data['CreatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt')
            ? data['UpdatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
