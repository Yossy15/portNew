import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import 'api_exception.dart';

part 'api_client.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final options = BaseOptions(
    baseUrl: AppConstants.apiBaseUrl,
    connectTimeout: AppConstants.networkTimeout,
    receiveTimeout: AppConstants.networkTimeout,
    responseType: ResponseType.json,
    headers: <String, dynamic>{
      'Accept': 'application/json',
    },
  );

  final dio = Dio(options);

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            error: ApiException(
              error.message ?? 'Unknown error',
              statusCode: error.response?.statusCode,
            ),
          ),
        );
      },
    ),
  );

  return dio;
}

