import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/section_container.dart';
import 'package:portfolio/features/projects/domain/project.dart';
import 'package:portfolio/responsive/responsive_layout.dart';
import 'projects_provider.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      data: (projects) {
        if (projects.isEmpty) {
          return const Text('No projects yet.');
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 16.0;
            const maxCardWidth = 320.0;

            final crossAxisCount =
                (constraints.maxWidth / (maxCardWidth + spacing))
                    .floor()
                    .clamp(1, 6);

            final cardWidth =
                (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                    crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: projects.map((project) {
                return SizedBox(
                  width: cardWidth,
                  child: ProjectCard(project: project),
                );
              }).toList(),
            );
          },
        );
      },
      loading: () => const _ProjectsShimmerGrid(),
      error: (error, stackTrace) => Text('Failed to load projects: $error'),
    );
  }
}

class _ProjectsShimmerGrid extends StatelessWidget {
  const _ProjectsShimmerGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        const maxCardWidth = 320.0;

        final crossAxisCount = (constraints.maxWidth / (maxCardWidth + spacing))
            .floor()
            .clamp(1, 6);

        final cardWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            9,
            (index) => SizedBox(
              width: cardWidth,
              child: AspectRatio(
                aspectRatio: 0.72,
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surfaceVariant,
                  highlightColor: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
