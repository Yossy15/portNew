import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'breakpoints.dart';

part 'screen_size_provider.g.dart';

enum ScreenSizeType {
  mobile,
  tablet,
  desktop,
}

extension ScreenSizeTypeExtension on ScreenSizeType {
  bool get isMobile => this == ScreenSizeType.mobile;
  bool get isTablet => this == ScreenSizeType.tablet;
  bool get isDesktop => this == ScreenSizeType.desktop;
}

@riverpod
class ScreenSize extends _$ScreenSize with WidgetsBindingObserver {
  @override
  ScreenSizeType build() {
    final binding = WidgetsBinding.instance;
    binding.addObserver(this);

    ref.onDispose(() {
      binding.removeObserver(this);
    });

    return _getSize();
  }

  @override
  void didChangeMetrics() {
    final size = _getSize();
    if (state != size) {
      state = size;
    }
  }

  ScreenSizeType _getSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;

    if (pixelRatio == 0.0) return ScreenSizeType.mobile;

    final width = size.width / pixelRatio;

    if (width >= kDesktopBreakpoint) {
      return ScreenSizeType.desktop;
    } else if (width >= kTabletBreakpoint) {
      return ScreenSizeType.tablet;
    } else {
      return ScreenSizeType.mobile;
    }
  }
}
