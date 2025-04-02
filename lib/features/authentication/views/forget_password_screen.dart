import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:financial_aid_project/utils/validators/validation.dart';
import 'package:financial_aid_project/routes/routes.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'ForgetPasswordFormKey');
  final TextEditingController _emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        print(
            'Attempting to reset password for: ${_emailController.text.trim()}');

        await AuthenticationRepository.instance
            .resetPassword(_emailController.text.trim());

        isLoading.value = false;
        print('Password reset email sent successfully');

        Get.snackbar(
          'Email Sent',
          'Password reset link has been sent to your email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColors.success.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Navigate back to login after a delay
        Future.delayed(const Duration(seconds: 3), () {
          Get.offNamed(TRoutes.login);
        });
      } catch (e) {
        isLoading.value = false;
        print('Error resetting password: $e');

        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColors.error.withOpacity(0.7),
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry, we'll help you recover your password",
                  style: TextStyle(
                    fontSize: 16,
                    color: TColors.textLightGray,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                _buildForgetPasswordForm(),
                const SizedBox(height: 16),
                _buildSendButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.toNamed(TRoutes.login),
                  style: TextButton.styleFrom(
                    foregroundColor: TColors.primary,
                  ),
                  child: const Text(
                    "Remember your password? Login",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'To reset your password, enter the email address you use to sign in. '
            'We will send you a link to reset your password.',
            style: TextStyle(
              fontSize: 14,
              color: TColors.textGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "yourmail@gmail.com",
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.email, color: TColors.primary),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: TValidator.validateEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: isLoading.value ? null : resetPassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            foregroundColor: TColors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBackgroundColor: TColors.primary.withOpacity(0.5),
          ),
          child: isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  "SEND RESET LINK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
