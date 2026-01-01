import 'package:dio/dio.dart';
import 'package:office_office/core/helpers/sharedpref_helper.dart';
import '../constants/strings.dart';
import '../networking/api_endpoints.dart';

class DioHelper {
  late Dio dio;
  DioHelper() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer ${AppConstants.savedToken}",
      },
    );
    dio = Dio(baseOptions);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (option, handler) {
          if (AppConstants.savedToken != null) {
            option.headers["Authorization"] =
                "Bearer ${AppConstants.savedToken}";
          }
          return handler.next(option);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 403) {
            try {
              final response = await dio.post(
                ApiEndpoints.baseUrl + ApiEndpoints.refreshToken,
                options: Options(
                  headers: {
                    'Authorization': "Bearer ${AppConstants.savedToken}",
                  },
                ),
              );
              await SharedprefHelper.setSecurityString(
                "token",
                response.data['token'],
              );
              AppConstants.savedToken = response.data['token'];
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${AppConstants.savedToken}';
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            } catch (e) {
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.delete(url, queryParameters: query);
  }
}
