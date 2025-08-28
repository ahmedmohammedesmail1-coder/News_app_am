import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:news_app_am/core/network/remote/api_endpoint.dart';
import 'package:news_app_am/core/util/constans/constans.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    if (dio != null) {
      return;
    }
    dio = Dio(
      BaseOptions(
        baseUrl: '$baseUrl$versionEndpoint',
      ),
    );
  }

// singlton
  static Dio getDio() {
    if (dio != null) {
      return dio!;
    }
    init();
    return dio!;
  }

  static Future<Either<String, Map<String, dynamic>>> get({
    required String path,
    Options? options,
    Map<String, dynamic>? queryParameters,
    String? search,
  }) async {
    try {
      Response response = await getDio().get(path,
          options: Options(headers: {'Authorization': 'bearer $apiKey'}),
          queryParameters: {
            'q': search,
            'searchIn': 'title,content',
            'language': 'en'
          });

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, Map<String, dynamic>>> searchNews({
    required String path,
    required String? text,
    required Map<String, String> queryParameters,
  }) async {
    try {
      Response response = await getDio().get(path,
          options: Options(headers: {'Authorization': 'bearer $apiKey'}),
          queryParameters: {
            'q': text,
            'searchIn': 'title,content',
            'language': 'en'
          });

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
