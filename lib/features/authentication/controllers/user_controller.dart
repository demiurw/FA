import 'package:get/get.dart';
import 'package:financial_aid_project/data/users/user_repositories.dart';
import 'package:financial_aid_project/data/repositories/authentication/user_model.dart';
import 'package:financial_aid_project/utils/popups/loaders.dart';

/// Controller for managing user-related data and operations
class UserController extends GetxController {
  static UserController get instance => Get.find();

  final UserRepository userRepository = Get.put(UserRepository());

  /// Fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      final user = await userRepository.fetchUserDetails();
      return user;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }
}
