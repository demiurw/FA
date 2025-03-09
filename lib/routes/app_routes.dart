import 'package:financial_aid_project/features/authentication/views/dashboard_screen.dart';
import 'package:financial_aid_project/features/authentication/views/home_screen.dart';
import 'package:financial_aid_project/features/authentication/views/login_screen.dart';
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
        name: TRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [TRouteMiddleware()]),
  ];
}
