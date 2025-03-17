import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/utils/popups/full_screen_loader.dart';
import 'package:financial_aid_project/utils/helpers/network_manager.dart';
import 'package:financial_aid_project/utils/constants/image_strings.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
import 'package:financial_aid_project/data/users/user_repositories.dart';
import 'package:financial_aid_project/data/repositories/authentication/user_model.dart';
import 'package:financial_aid_project/utils/popups/loaders.dart';
import 'package:financial_aid_project/utils/constants/enums.dart';

/// Controller for handling signup functionality
class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Text editing controllers for form fields
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  // Observable for hiding/showing password
  final hidePassword = true.obs;

  // Form key for validation
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Repository instances
  final userRepository = Get.put(UserRepository());

  /// Handles the user registration process
  Future<void> registerUser() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Creating your account...', TImages.regLoadAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & Password Authentication
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Create user record in the Firestore
      await userRepository.createUser(
        UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: '${firstName.text.trim()}${lastName.text.trim()}',
          email: email.text.trim(),
          role: AppRole.user,
          createdAt: DateTime.now(),
        ),
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Success',
          message: 'Your account has been created. Please login.');

      // Redirect to login
      Get.offAllNamed('/login');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
