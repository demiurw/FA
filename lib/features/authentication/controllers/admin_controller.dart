import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/data/repositories/authentication/admin_model.dart';
import 'package:financial_aid_project/data/repositories/authentication/admin_repository.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
import 'package:financial_aid_project/utils/popups/full_screen_loader.dart';
import 'package:financial_aid_project/utils/helpers/network_manager.dart';
import 'package:financial_aid_project/utils/constants/image_strings.dart';
import 'package:financial_aid_project/utils/popups/loaders.dart';

/// Controller for managing admin operations.
class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final adminRepository = Get.put(AdminRepository());

  // Form controllers for adding new admin
  final username = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // Password visibility
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  // Form key
  final addAdminFormKey = GlobalKey<FormState>();

  /// Fetches the current admin details.
  Future<AdminModel> fetchAdminDetails() async {
    try {
      final uid = AuthenticationRepository.instance.authUser!.uid;
      final admin = await adminRepository.fetchAdminDetails(uid);
      return admin;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error fetching admin details', message: e.toString());
      return AdminModel.empty();
    }
  }

  /// Checks if the current user is an admin.
  Future<bool> isUserAdmin() async {
    return await adminRepository.isUserAdmin();
  }

  /// Adds a new admin to the system.
  Future<void> addNewAdmin() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Creating new admin account...', TImages.regLoadAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register with Firebase Authentication
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Create admin record in Firestore
      await adminRepository.createAdmin(
        AdminModel(
          id: userCredential.user!.uid,
          username: username.text.trim(),
          email: email.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          createdAt: DateTime.now(),
        ),
      );

      // Clear form fields
      _clearFormFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Success', message: 'New admin account created successfully.');
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show error message
      TLoaders.errorSnackBar(
          title: 'Failed to create admin account', message: e.toString());
    }
  }

  /// Get all admins in the system.
  Future<List<AdminModel>> getAllAdmins() async {
    try {
      return await adminRepository.getAllAdmins();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error fetching admins', message: e.toString());
      return [];
    }
  }

  /// Clear form fields after adding an admin.
  void _clearFormFields() {
    username.clear();
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  @override
  void onClose() {
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
