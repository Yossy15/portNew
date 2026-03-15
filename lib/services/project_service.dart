import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/network/api_client.dart';
import '../features/projects/domain/project.dart';
import '../mock/mock_projects.dart';

part 'project_service.g.dart';

class ProjectService {
  ProjectService(this._dio);

  final Dio _dio;

  Future<List<Project>> getProjects() async {
    // TODO: Replace with real API call when backend is ready.
    // final response = await _dio.get<List<dynamic>>('/projects');
    // final data = response.data ?? <dynamic>[];
    // return data
    //     .map((dynamic e) => Project.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future<void>.delayed(const Duration(milliseconds: 400));
    return mockProjects;
  }
}

@riverpod
ProjectService projectService(ProjectServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return ProjectService(dio);
}

