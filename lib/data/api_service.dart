import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saavan_app/ui/imports.dart';

class ApiService {
  static Future<Object> getData({required String path}) async {
    try {
      Response response = await ApiClient().dio.get(path);
      print(path);
      print(response.statusCode);
      /* print(response.data);*/

      return Success(data: response);
    } on InternalServerErrorException catch (_, e) {
      return ApiError(massage: e.toString());
    } on BadRequestException catch (_, e) {
      return ApiError(massage: e.toString());
    } on ConflictException catch (_, e) {
      return ApiError(massage: e.toString());
    } on UnauthorizedException catch (_, e) {
      return ApiError(massage: e.toString());
    } on NotFoundException catch (_, e) {
      return ApiError(massage: e.toString());
    } on NoInternetConnectionException catch (_, e) {
      return ApiError(massage: e.toString());
    } on DeadlineExceededException catch (_, e) {
      return ApiError(massage: e.toString());
    } catch (e) {
      return ApiError(massage: e.toString());
    }
  }

  static Future<String?> getUrlLocation(String url) async {
    var uri = Uri.parse(url);
    var request = await ApiClient().dio.getUri(
          uri,
          options: Options(
              followRedirects: false,
              validateStatus: (int? status) {
                return ((status ?? 0) < 500);
              }),
        );
    return request.headers.value(HttpHeaders.locationHeader);
  }
}

class ApiClient {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: "https://www.jiosaavn.com/api.php?"));

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: "https://www.jiosaavn.com/api.php?",
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}
