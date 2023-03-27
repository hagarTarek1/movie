import 'package:dio/dio.dart';

import 'endPoints.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        queryParameters: {'api_key': apiKey},
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get({required String path, Map<String, dynamic>? queryParameters}) async {
    try{
      Response response=await
      dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    }
    catch (e){rethrow;}
  }
}
