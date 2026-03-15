import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../services/project_service.dart';
import '../domain/project.dart';

part 'projects_provider.g.dart';

@riverpod
Future<List<Project>> projects(ProjectsRef ref) async {
  final service = ref.watch(projectServiceProvider);
  return service.getProjects();
}

