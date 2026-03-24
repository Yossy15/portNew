import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:portfolio/gen/assets.gen.dart';
import 'package:portfolio/responsive/screen_size_provider.dart';
import 'package:portfolio/widgets/cached_network_image_box.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeroSection extends ConsumerStatefulWidget {
  const HomeHeroSection({super.key});

  @override
  ConsumerState<HomeHeroSection> createState() => _HomeHeroSectionState();
}

class _HomeHeroSectionState extends ConsumerState<HomeHeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _offset = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // simulate load delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => loading = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTextShimmer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = ref.watch(screenSizeProvider);

    return FadeTransition(
      opacity: _opacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Profile picture
          loading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : CachedNetworkImageBox(
                  imageUrl: Assets.images.profile.path,
                  borderRadius: 50,
                  width: 100,
                  height: 100,
                  enableFullScreen: false,
                ),
          const Gap(16),

          // Texts
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (loading)
                  _buildTextShimmer(
                      switch (screenSize) {
                        ScreenSizeType.mobile => 200,
                        ScreenSizeType.tablet => 300,
                        ScreenSizeType.desktop => 400,
                      },
                      switch (screenSize) {
                        ScreenSizeType.mobile => 24,
                        ScreenSizeType.tablet => 32,
                        ScreenSizeType.desktop => 40,
                      }),
                if (!loading)
                  Text(
                    'Hi, I\'m Suwijak Jaisuk (YOSSY)',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: switch (screenSize) {
                        ScreenSizeType.mobile => 18,
                        ScreenSizeType.tablet => 24,
                        ScreenSizeType.desktop => 32,
                      },
                    ),
                  ),
                const Gap(12),
                if (loading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextShimmer(
                          switch (screenSize) {
                            ScreenSizeType.mobile => 250,
                            ScreenSizeType.tablet => 350,
                            ScreenSizeType.desktop => 500,
                          },
                          18),
                      const Gap(6),
                      _buildTextShimmer(
                          switch (screenSize) {
                            ScreenSizeType.mobile => 180,
                            ScreenSizeType.tablet => 300,
                            ScreenSizeType.desktop => 400,
                          },
                          18),
                    ],
                  ),
                if (!loading)
                  Text(
                    'Flutter developer focused on building fast, accessible, and beautiful web & mobile experiences.',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                      fontSize: switch (screenSize) {
                        ScreenSizeType.mobile => 14,
                        ScreenSizeType.tablet => 16,
                        ScreenSizeType.desktop => 18,
                      },
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
              ],
            ),
          ),

          if (screenSize != ScreenSizeType.mobile) ...[
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (context.canPop()) context.pop();
                    showDialog(
                      context: context,
                      builder: (context) => const _PinputDialog(),
                    );
                  },
                  child: const Text('ผลงาน เบบี๋ ❤️'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}

class _PinputDialog extends StatefulWidget {
  const _PinputDialog();

  @override
  State<_PinputDialog> createState() => _PinputDialogState();
}

class _PinputDialogState extends State<_PinputDialog>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool showError = false;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _validate() {
    const correctPin = '1115';
    if (controller.text == correctPin) {
      context.go('/start-beb');
      Navigator.of(context).pop();
    } else {
      setState(() => showError = true);
      controller.clear();
      _shakeController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black87),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.redAccent),
      ),
      textStyle: defaultPinTheme.textStyle!.copyWith(color: Colors.redAccent),
    );

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset = _shakeAnimation.value * (showError ? 1 : 0);
        return Transform.translate(
          offset: Offset(offset * (controller.text.isEmpty ? 0 : 1), 0),
          child: AlertDialog(
            title: Row(
              children: [
                const Text('รหัส วันเกิดเค้ากับบี๋'),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Pinput(
                    controller: controller,
                    focusNode: focusNode,
                    forceErrorState: showError,
                    defaultPinTheme: defaultPinTheme,
                    errorPinTheme: errorPinTheme,
                    onCompleted: (pin) => _validate(),
                  ),
                  if (showError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'รหัสไม่ถูกต้องจ้าาา',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
