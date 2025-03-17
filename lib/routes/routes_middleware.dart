import 'package:financial_aid_project/routes/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
/* // bthis is the first one
class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: TRoutes.login);
  }
}
*/
/*
class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthenticationRepository.instance.isAuthenticated && route != TRoutes.login) {
      return const RouteSettings(name: TRoutes.login);
    }
    return null;
  }
}
*/

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Allow access to the home and login pages without redirecting
    if (route == TRoutes.home ||
        route == TRoutes.login ||
        route == TRoutes.signup) {
      return null;
    }

    // If not authenticated and trying to access a protected route, redirect to login
    if (!AuthenticationRepository.instance.isAuthenticated) {
      return const RouteSettings(name: TRoutes.login);
    }

    return null;
  }
}
