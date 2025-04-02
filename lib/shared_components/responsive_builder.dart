import 'package:flutter/material.dart';

/// A widget that builds different layouts based on screen size.
class ResponsiveBuilder extends StatelessWidget {
  /// Builder function for mobile layout (narrow screens)
  final Widget Function(BuildContext context, BoxConstraints constraints)
      mobileBuilder;

  /// Builder function for tablet layout (medium-sized screens)
  final Widget Function(BuildContext context, BoxConstraints constraints)
      tabletBuilder;

  /// Builder function for desktop layout (wide screens)
  final Widget Function(BuildContext context, BoxConstraints constraints)
      desktopBuilder;

  /// Screen width threshold for mobile layout
  final double mobileBreakpoint;

  /// Screen width threshold for tablet layout
  final double tabletBreakpoint;

  /// Constructor for ResponsiveBuilder.
  const ResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 900,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          // Mobile layout
          return mobileBuilder(context, constraints);
        } else if (constraints.maxWidth < tabletBreakpoint) {
          // Tablet layout
          return tabletBuilder(context, constraints);
        } else {
          // Desktop layout
          return desktopBuilder(context, constraints);
        }
      },
    );
  }
}
