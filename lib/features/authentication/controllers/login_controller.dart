import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/utils/popups/full_screen_loader.dart';
import 'package:financial_aid_project/utils/helpers/network_manager.dart';
import 'package:financial_aid_project/utils/constants/image_strings.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
import 'package:financial_aid_project/data/users/user_repositories.dart';
import 'package:financial_aid_project/utils/constants/enums.dart';
import 'package:financial_aid_project/data/repositories/authentication/user_model.dart';
import 'package:financial_aid_project/utils/popups/loaders.dart';
import 'package:financial_aid_project/features/authentication/controllers/user_controller.dart';

/// Controller for handling login functionality
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ??
        ''; // show previous passwords on in entry fields on startup
    super.onInit();
  }

  /// Handles email and password sign-in process
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging in Admin Account...', TImages.regLoadAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write(
            'REMEMBER_ME_EMAIL',
            email.text
                .trim()); // remmber me passsword is stored email and password here for retrieval later
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
          email.text.trim(),
          password.text
              .trim()); // replace with the email and password above IT WILL BE THE ADMIN'S EMAIL AND PASSWORD

      // Fetch user details and assign to UserController
      final user = await UserController.instance.fetchUserDetails();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // If user is not admin, logout and return
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(
            title: 'Not Authorized',
            message: 'You are not authorized or do have access. Contact Admin');
      } else {
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Registering Admin Account...', TImages.regLoadAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          'testemail@gmail.com',
          'Password1#'); // replace with the email and password above IT WILL BE THE ADMIN'S EMAIL AND PASSWORD

      // Create admin record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'CwT', //maybe this is defeault name for every admin
          lastName: 'Admin',
          email: 'testemail@gmail.com', //change this to email from above
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
