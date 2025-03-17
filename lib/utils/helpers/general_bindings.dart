import 'package:get/get.dart';
import 'network_manager.dart'; // Ensure these are correct
import 'package:financial_aid_project/features/authentication/controllers/user_controller.dart'; // Ensure these are correct
import 'package:financial_aid_project/features/authentication/controllers/login_controller.dart';
import 'package:financial_aid_project/features/authentication/controllers/signup_controller.dart';
import 'package:financial_aid_project/features/authentication/controllers/admin_controller.dart';
import 'package:financial_aid_project/data/repositories/authentication/admin_repository.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(AdminRepository());
    Get.put(AdminController());
  }
}
