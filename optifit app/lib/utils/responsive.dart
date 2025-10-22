import 'package:flutter/material.dart';

/// Breakpoint constants for responsive design
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

/// Device type enum
enum DeviceType { mobile, tablet, desktop }

/// Responsive helper class for building adaptive layouts
class Responsive {
  /// Get current device type based on width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < Breakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width < Breakpoints.tablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Breakpoints.mobile;

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= Breakpoints.mobile && width < Breakpoints.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Breakpoints.tablet;

  /// Get responsive value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets padding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: value(
        context,
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      ),
      vertical: value(
        context,
        mobile: 12.0,
        tablet: 16.0,
        desktop: 20.0,
      ),
    );
  }

  /// Get responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive grid columns
  static int gridColumns(BuildContext context) {
    return value(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }

  /// Get responsive max width for content
  static double maxContentWidth(BuildContext context) {
    return value(
      context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1200,
    );
  }
}

/// Widget builder that provides device type
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = Responsive.getDeviceType(context);
        return builder(context, deviceType);
      },
    );
  }
}

/// Widget that displays different widgets based on screen size
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
        }
      },
    );
  }
}

/// Extension on BuildContext for easier access to responsive helpers
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  DeviceType get deviceType => Responsive.getDeviceType(this);
}
