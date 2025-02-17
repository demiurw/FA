import 'package:financial_aid_project/features/authentication/views/dashboard_screen.dart';
import 'package:financial_aid_project/features/authentication/views/home_screen.dart';
import 'package:financial_aid_project/features/authentication/views/login_screen.dart';
import 'package:financial_aid_project/routes/routes.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen()),
  ];
}
