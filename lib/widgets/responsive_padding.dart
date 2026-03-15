import 'package:flutter/widgets.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    double horizontal = 16;
    if (width >= 600 && width < 1024) {
      horizontal = 32;
    } else if (width >= 1024) {
      horizontal = 64;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 24),
      child: child,
    );
  }
}

