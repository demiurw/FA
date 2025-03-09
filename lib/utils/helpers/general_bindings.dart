import 'package:get/get.dart';
import 'network_manager.dart'; // Ensure these are correct
import 'package:financial_aid_project/features/authentication/controllers/user_controller.dart'; // Ensure these are correct

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
