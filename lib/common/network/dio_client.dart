import 'package:dio/dio.dart' show Dio, ResponseType;
import 'package:injectable/injectable.dart';

import '../utils/constants/api_constants.dart';
import 'dio_interceptor.dart';

@lazySingleton
class DioClient {
  DioClient(this.dio) {
    dio
      ..options.baseUrl = ""
      ..options.headers = ApiConstants.headers
      ..options.connectTimeout = ApiConstants.connectionTimeout
      ..options.receiveTimeout = ApiConstants.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }
  final Dio dio;
}
