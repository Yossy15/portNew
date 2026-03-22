import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:portfolio/gen/assets.gen.dart';
import 'package:portfolio/responsive/screen_size_provider.dart';
import 'package:portfolio/widgets/cached_network_image_box.dart';

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          CachedNetworkImageBox(
            imageUrl: Assets.images.profile.path,
            borderRadius: 50,
            width: 100,
            height: 100,
          ),
            // Assets.images.profile.image(
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
          const Gap(16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const _PinputDialog();
                      },
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

class _PinputDialogState extends State<_PinputDialog> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool showError = false;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _validate() {
    // แก้ไขรหัสตรงนี้ตามต้องการ (เช่น วันเกิด)
    const correctPin = '1115';

    if (controller.text == correctPin) {
      context.go('/start-beb');
      Navigator.of(context).pop();
    } else {
      setState(() {
        showError = true;
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        // color: Color.fromRGBO(30, 60, 87, 1),
      ),
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

    return AlertDialog(
      title: Row(
        children: [
          const Text('รหัส วันเกิดเค้ากับบี๋'),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
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
              // onChanged: (value) {
              //   if (showError) {
              //     setState(() => showError = false);
              //   }
              // },
            ),
            if (showError)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'รหัสไม่ถูกต้องจ้าาา',
                  style: TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     child: const Text('ยกเลิก'),
      //   ),
      //   // TextButton(
      //   //   onPressed: _validate,
      //   //   child: const Text('ตกลง'),
      //   // ),
      // ],
    );
  }
}
