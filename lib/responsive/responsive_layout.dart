import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
export 'screen_size_provider.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= kTabletBreakpoint) {
      if (width >= kDesktopBreakpoint) {
        return desktop;
      }
      return tablet;
    }
    return mobile;
  }
}

extension ResponsiveContext on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width < kMobileBreakpoint;
  bool get isTablet => MediaQuery.sizeOf(this).width < kTabletBreakpoint;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= kDesktopBreakpoint;
}
