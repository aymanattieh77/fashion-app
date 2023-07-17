import 'package:dio/dio.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const rapidApiKey = 'X-RapidAPI-Key';
const rapidApiHost = 'X-RapidAPI-Host';

class DioFactroy {
  late Dio dio;

  DioFactroy() {
    final headers = {
      rapidApiKey: dotenv.env[AppConstants.apiKey],
      rapidApiHost: dotenv.env[AppConstants.apiHost],
    };

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
        ),
      );
    }
  }
}
