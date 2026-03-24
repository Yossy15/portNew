import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/gen/assets.gen.dart';

class AppNavBar extends StatefulWidget implements PreferredSizeWidget {
  const AppNavBar({
    super.key,
    this.onHomeTap,
    this.onProjectsTap,
    this.onAboutTap,
    this.onContactTap,
  });

  final VoidCallback? onHomeTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onContactTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  // เก็บ hover state ของเมนู
  final Map<String, bool> _isHovering = {
    'Home': false,
    'Projects': false,
    'About': false,
    'Contact': false,
  };

  bool _logoHover = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: MouseRegion(
        onEnter: (_) => setState(() => _logoHover = true),
        onExit: (_) => setState(() => _logoHover = false),
        child: GestureDetector(
          onTap: () => context.go('/'),
          child: AnimatedScale(
            scale: _logoHover ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: ClipOval(
              child: Assets.icons.logo.image(
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      actions: [
        _navButton(context, 'Home', widget.onHomeTap ?? () => context.go('/')),
        _navButton(context, 'Projects',
            widget.onProjectsTap ?? () => context.go('/projects')),
        _navButton(
            context, 'About', widget.onAboutTap ?? () => context.go('/about')),
        _navButton(context, 'Contact',
            widget.onContactTap ?? () => context.go('/contact')),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _navButton(BuildContext context, String label, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[label] = true),
      onExit: (_) => setState(() => _isHovering[label] = false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovering[label]! ? Colors.blueAccent : Colors.black,
            fontWeight:
                _isHovering[label]! ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
