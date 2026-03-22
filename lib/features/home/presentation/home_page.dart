import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/widgets/responsive_padding.dart';
import 'package:portfolio/widgets/app_navbar.dart';
import 'widgets/home_hero_section.dart';
import 'package:portfolio/features/projects/presentation/projects_page.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(
        onHomeTap: () => _scrollToSection(_homeKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onAboutTap: () => _scrollToSection(_aboutKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: ResponsivePadding(
          child: Column(
            children: <Widget>[
              _HomeSections(
                homeKey: _homeKey,
                projectsKey: _projectsKey,
                aboutKey: _aboutKey,
                contactKey: _contactKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeSections extends StatelessWidget {
  const _HomeSections({
    required this.homeKey,
    required this.projectsKey,
    required this.aboutKey,
    required this.contactKey,
  });

  final GlobalKey homeKey;
  final GlobalKey projectsKey;
  final GlobalKey aboutKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.sizeOf(context).width < 600;
    final double gapSize = isMobile ? 32 : 48;
    final theme = Theme.of(context);

    return Column(
      children: <Widget>[
        if (isMobile)
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
        Gap(7),
        SizedBox(key: homeKey, child: const HomeHeroSection()),
        // Gap(gapSize),
        // const HomeIntroSection(),
        // Gap(gapSize),
        // const HomeSocialSection(),
        Gap(gapSize),
        SizedBox(
            key: projectsKey,
            width: double.infinity,
            child: const ProjectsPage()),
        // Gap(gapSize),
        // SizedBox(
        //     key: aboutKey, width: double.infinity, child: const AboutPage()),
        // Gap(gapSize),
        // SizedBox(
        //     key: contactKey,
        //     width: double.infinity,
        //     child: const ContactPage()),
      ],
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
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
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
