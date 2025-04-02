import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:financial_aid_project/features/authentication/controllers/login_controller.dart';
import 'package:financial_aid_project/utils/validators/validation.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:financial_aid_project/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // Use a local form key instead of one from controller
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController.instance;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(80),
              color: TColors.primary,
              child: Image.asset(
                'assets/images/hero.png',
                height: 500,
                width: 500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Sign in to your account (Admin or User)",
                        style: TextStyle(
                          fontSize: 16,
                          color: TColors.textLightGray,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: loginController.email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(EvaIcons.email, color: TColors.primary),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: TValidator.validateEmail,
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => TextFormField(
                          controller: loginController.password,
                          obscureText: loginController.hidePassword.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(EvaIcons.lock,
                                color: TColors.primary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginController.hidePassword.value
                                    ? EvaIcons.eyeOff
                                    : EvaIcons.eye,
                                color: TColors.primary,
                              ),
                              onPressed: () {
                                loginController.hidePassword.value =
                                    !loginController.hidePassword.value;
                              },
                            ),
                          ),
                          validator: TValidator.validatePassword,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: loginController.rememberMe.value,
                                  activeColor: TColors.primary,
                                  onChanged: (value) {
                                    loginController.rememberMe.value =
                                        value ?? false;
                                  },
                                ),
                              ),
                              const Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Use GetX navigation as the middleware now allows this route
                              Get.toNamed(TRoutes.forgetPassword);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: TColors.primary,
                            ),
                            child: const Text("Forgot Password?"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_loginFormKey.currentState!.validate()) {
                            await loginController.emailAndPasswordSignIn();
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.white,
                                  foregroundColor: TColors.black,
                                  side: const BorderSide(color: TColors.grey),
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: const Icon(EvaIcons.google),
                                onPressed: () {
                                  // Implement Google sign-in logic
                                },
                                label: const Text("Log In with Google"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.black,
                                  foregroundColor: TColors.white,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: const Icon(Icons.apple),
                                onPressed: () {
                                  // Implement Apple sign-in logic
                                },
                                label: const Text("Log In with Apple"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => Get.toNamed(TRoutes.signup),
                        style: TextButton.styleFrom(
                          foregroundColor: TColors.primary,
                        ),
                        child: const Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
