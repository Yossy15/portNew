import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:portfolio/features/projects/domain/project.dart';
import 'cached_network_image_box.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(project.title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.description),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: project.techStack
                        .map((tech) => Chip(label: Text(tech)))
                        .toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        // project.liveDemoUrl != null ? () {} : null,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (project.heroImage != null &&
                  project.heroImage!.isNotEmpty) ...<Widget>[
                CachedNetworkImageBox(imageUrl: project.heroImage!),
                const Gap(12),
              ],
              Text(
                project.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              Text(
                project.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: theme.textTheme.bodyMedium,
              ),
              const Gap(12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: project.techStack
                    .map(
                      (tech) => Chip(
                        label: Text(tech),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
              const Gap(12),
              Row(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      // TODO: open GitHub
                    },
                    icon: const Icon(Icons.code),
                    label: const Text('GitHub'),
                  ),
                  if (project.liveDemoUrl != null) ...<Widget>[
                    const Gap(8),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: open live demo
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Live demo'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
