import 'package:dio/dio.dart';
import '../local/token_data_provide.dart';

enum ApiExceptionType { network, auth, other }

class ApiException {
  final ApiExceptionType type;

  ApiException(this.type);
}

class Api {
  final _dataProvide = TokenDataProvider();
  late Dio dio;

  Api() {
    dio = _createDio();
    dio = _addInterceptors();
  }

  Dio _createDio() {
    return Dio(BaseOptions(
        receiveDataWhenStatusError: false,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        baseUrl: "https://5c24-178-34-184-187.eu.ngrok.io"));
  }

  Dio _addInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => _requestInterceptor(options, handler),
      onResponse: (response, handler) => handler.next(response),
      onError: (dioError, handler) => handler.next(dioError),
    ));

    return dio;
  }

  dynamic _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _dataProvide.getAuthToken();
    if (token == null) return handler.next(options);

    options.headers.addAll({"Authorization": "Bearer $token"});
    return handler.next(options);
  }
}
