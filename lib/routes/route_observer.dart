/*
 * This file is currently not in use but contains a template for route observation
 * that might be implemented in the future. The commented code below shows
 * an example of how to implement route observation with GetX.
 * 
 * When needed, uncomment and implement the necessary classes and methods.
 */

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sidebar_controller.dart'; // Adjust path as necessary

class RouteObservers extends GetObserver {
  /// Called when a route is popped from the navigation stack.
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());
    if (previousRoute != null) {
      // Check the route name and update the active item in the sidebar accordingly
      for (var routeName in routePaths) {
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
      for (var routeName in routePaths) {
        if (route.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
          break; // Found the matching route, break out of the loop
        }
      }
    }
  }
}
*/
