import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({
    super.key,
    this.title = 'Your Name',
    this.onHomeTap,
    this.onProjectsTap,
    this.onAboutTap,
    this.onContactTap,
  });

  final String title;
  final VoidCallback? onHomeTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onContactTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          onPressed: onHomeTap ?? () => context.go('/'),
          child: const Text('Home'),
        ),
        TextButton(
          onPressed: onProjectsTap ?? () => context.go('/projects'),
          child: const Text('Projects'),
        ),
        TextButton(
          onPressed: onAboutTap ?? () => context.go('/about'),
          child: const Text('About'),
        ),
        TextButton(
          onPressed: onContactTap ?? () => context.go('/contact'),
          child: const Text('Contact'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

