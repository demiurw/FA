import 'package:financial_aid_project/features/authentication/views/admin_dashboard_screen.dart';
import 'package:financial_aid_project/features/authentication/views/dashboard_screen.dart';
import 'package:financial_aid_project/features/authentication/views/home_screen.dart';
import 'package:financial_aid_project/features/authentication/views/login_screen.dart';
import 'package:financial_aid_project/features/authentication/views/signup.screen.dart';
import 'package:financial_aid_project/routes/routes_middleware.dart';
import 'package:financial_aid_project/routes/routes.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final pages = [
    GetPage(
        name: TRoutes.home,
        page: () => const HomeScreen(),
        middlewares: [TRouteMiddleware()]), //
    GetPage(
        name: TRoutes.login,
        page: () => const LoginScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.signup,
        page: () => const SignupScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.userDashboard,
        page: () => const UserDashboardScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.adminDashboard,
        page: () => const AdminDashboardScreen(),
        middlewares: [TRouteMiddleware()]),
  ];
}
