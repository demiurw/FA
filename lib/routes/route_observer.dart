import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'sidebar_controller.dart'; // Adjust path as necessary and add
import 'routes.dart';

/*
class RouteObservers extends GetObserver {
  /// Called when a route is popped from the navigation stack.
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());
    if (previousRoute != null) {
      // Check the route name and update the active item in the sidebar accordingly
      for (var routeName in TRoutes.sideMenuItems) {
        // example fr what to put
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
          break; // Found the matching route, break out of the loop
        }
      }
    }
  }

  /// Called when a route is pushed onto the navigation stack.
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());
    if (route != null) {
      // Check the route name and update the active item in the sidebar accordingly
      for (var routeName in TRoutes.sideMenuItems) {
        //example of what to put
        if (route.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
          break; // Found the matching route, break out of the loop
        }
      }
    }
  }
}

*/
