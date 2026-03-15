import '../features/projects/domain/project.dart';

import 'dart:math';

final random = Random();

final List<List<String>> techStacks = [
  ['Flutter', 'Dart', 'Riverpod'],
  ['Flutter', 'Firebase'],
  ['Flutter', 'REST API', 'Provider'],
  ['Flutter', 'GraphQL'],
  ['Flutter', 'Clean Architecture'],
  ['Flutter', 'Bloc', 'Dio'],
];

final List<String> heroImages = [
  'https://picsum.photos/seed/portfolio-web/1200/800',
  'https://picsum.photos/seed/ecommerce-app/1200/800',
  'https://picsum.photos/seed/design-system/1200/800',
];

final List<Project> mockProjects = List.generate(
  10,
  (index) => Project(
    id: '${index + 1}',
    title: 'Project ${index + 1}',
    description:
        'Project A responsive Flutter web portfolio with Riverpod and GoRouter. (${index + 1})',
    techStack: techStacks[random.nextInt(techStacks.length)],
    githubUrl: 'https://github.com/yourname/project-${index + 1}',
    liveDemoUrl: 'null',
    heroImage: heroImages[random.nextInt(heroImages.length)],
  ),
);

// final List<Project> mockProjects = <Project>[
//   Project(
//     id: '1',
//     title: 'Portfolio Web',
//     description:
//         'A responsive Flutter web portfolio with Riverpod and GoRouter.',
//     techStack: <String>['Flutter', 'Dart', 'Riverpod', 'GoRouter'],
//     githubUrl: 'https://github.com/yourname/portfolio',
//     liveDemoUrl: 'https://your-portfolio.web.app',
//     heroImage: 'https://picsum.photos/seed/portfolio-web/1200/800',
//   ),
//   Project(
//     id: '2',
//     title: 'Mobile E‑commerce App',
//     description:
//         'A clean architecture e‑commerce app with secure checkout and analytics.',
//     techStack: <String>['Flutter', 'Firebase', 'Clean Architecture'],
//     githubUrl: 'https://github.com/yourname/ecommerce-app',
//     liveDemoUrl: null,
//     heroImage: 'https://picsum.photos/seed/ecommerce-app/1200/800',
//   ),
//   Project(
//     id: '3',
//     title: 'Design System',
//     description:
//         'Reusable component library and design system for Flutter products.',
//     techStack: <String>['Flutter', 'Design System', 'Theming'],
//     githubUrl: 'https://github.com/yourname/design-system',
//     liveDemoUrl: null,
//     heroImage: 'https://picsum.photos/seed/design-system/1200/800',
//   ),
// ];
