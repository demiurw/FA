import 'package:get/get.dart';
import 'package:financial_aid_project/data/repositories/authentication/admin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_aid_project/utils/exceptions/platform_exceptions.dart';
import 'package:financial_aid_project/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:financial_aid_project/utils/exceptions/format_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRepository extends GetxController {
  static AdminRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Function to save admin data to Firestore.
  Future<void> createAdmin(AdminModel admin) async {
    try {
      // Check if an admin already exists with the same username
      final adminSnapshot = await _db
          .collection('Admins')
          .where('Username', isEqualTo: admin.username)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        throw 'An admin with this username already exists';
      }

      // Save the admin record
      await _db.collection('Admins').doc(admin.id).set(admin.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Function to fetch admin details based on user ID.
  Future<AdminModel> fetchAdminDetails(String uid) async {
    try {
      final docSnapshot = await _db.collection('Admins').doc(uid).get();
      if (docSnapshot.exists) {
        return AdminModel.fromSnapshot(docSnapshot);
      } else {
        throw 'Admin not found';
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Function to check if the current authenticated user is an admin.
  Future<bool> isUserAdmin() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      // Check if the user exists in the Admins collection
      final adminSnapshot = await _db.collection('Admins').doc(user.uid).get();
      return adminSnapshot.exists;
    } catch (_) {
      return false;
    }
  }

  /// Function to check if an admin exists with the given email
  Future<bool> isAdminEmail(String email) async {
    try {
      final adminSnapshot =
          await _db.collection('Admins').where('Email', isEqualTo: email).get();
      return adminSnapshot.docs.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Function to get all admins
  Future<List<AdminModel>> getAllAdmins() async {
    try {
      final querySnapshot = await _db.collection('Admins').get();
      return querySnapshot.docs
          .map((doc) => AdminModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
