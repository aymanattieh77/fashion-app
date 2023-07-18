import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioFactroy {
  Dio getDio([Map<String, String>? headers]);
}

class DioFactroyImpl implements DioFactroy {
  @override
  Dio getDio([Map<String, String>? headers]) {
    Dio dio;
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 1000 * 30),
      receiveTimeout: const Duration(milliseconds: 1000 * 30),
      sendTimeout: const Duration(milliseconds: 1000 * 30),
      receiveDataWhenStatusError: true,
      headers: headers,
    );
    dio = Dio(baseOptions);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          responseBody: false,
          requestHeader: true,
        ),
      );
    }
    return dio;
  }
}
