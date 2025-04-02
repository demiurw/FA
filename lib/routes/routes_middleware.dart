import 'package:financial_aid_project/routes/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Define public routes that don't require authentication
    final publicRoutes = [
      TRoutes.home,
      TRoutes.login,
      TRoutes.signup,
      TRoutes.forgetPassword, // Allow access to forgot password without auth
    ];

    // If route is public, allow access
    if (publicRoutes.contains(route)) {
      return null;
    }

    // If not authenticated and trying to access a protected route, redirect to login
    if (!AuthenticationRepository.instance.isAuthenticated) {
      return const RouteSettings(name: TRoutes.login);
    }

    return null;
  }
}
