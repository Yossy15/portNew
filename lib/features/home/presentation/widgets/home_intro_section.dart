import 'package:flutter/material.dart';

class HomeIntroSection extends StatelessWidget {
  const HomeIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What I do',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'I specialize in building high-quality Flutter applications with clean architecture, '
          'robust state management, and a focus on performance and developer experience.',
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

