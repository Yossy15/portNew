import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({
    super.key,
    this.title = 'PP.Porfolio',
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
      title: TextButton.icon(
        onPressed: () => context.go('/'),
        icon: const Icon(Icons.g_mobiledata_outlined, size: 40,),
        label: Text(title),
        style: ButtonStyle(
          backgroundBuilder: (context, states, child) => Container(
            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: child,
          ),
        ),
      ),
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

