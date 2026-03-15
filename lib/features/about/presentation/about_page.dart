import 'package:flutter/material.dart';

import '../../../widgets/section_container.dart';
import '../../../widgets/app_navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return
        // Scaffold(
        //   appBar: const AppNavBar(title: 'About'),
        //   body:
        SectionContainer(
      title: 'About me',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Profile',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Short bio about you, your background, and what you enjoy building.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Skills',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              Chip(label: Text('Flutter')),
              Chip(label: Text('Dart')),
              Chip(label: Text('Clean Architecture')),
              Chip(label: Text('Riverpod')),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Experience',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'List relevant roles, projects, and impact here.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
      // ),
    );
  }
}
