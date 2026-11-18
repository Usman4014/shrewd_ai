import 'package:dio/dio.dart';
import 'package:shrewd_ai/core/constants/api_constants.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(
          milliseconds: ApiConstants.connectTimeout,
        ),
        receiveTimeout: Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        sendTimeout: Duration(
          milliseconds: ApiConstants.sendTimeout,
        ),
        headers: {
          'Accept': ApiConstants.accept,
        },
      ),
    );
  }
}