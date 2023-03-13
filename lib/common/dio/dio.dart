import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/secure_storage/secure_storage.dart';
import 'package:delivery_codefactory/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final providerDio = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(providerStorage);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d('[REQ] [${options.method}] [${options.uri}]');

    if (options.headers[Token_Key_Access] == 'true') {
      options.headers.remove(Token_Key_Access);

      final accessToken = await storage.read(key: Token_Key_Access);

      options.headers.addAll({authorization: 'Bearer $accessToken'});
    }
    if (options.headers[Token_Key_Refresh] == 'true') {
      options.headers.remove(Token_Key_Refresh);

      final refreshToken = await storage.read(key: Token_Key_Refresh);

      options.headers.addAll({authorization: 'Bearer $refreshToken'});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('[RES] [${response.requestOptions.method}] [${response.requestOptions.uri}]');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.d('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: Token_Key_Refresh);

    if (refreshToken == null) {
      return;
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      try {
        final dio = Dio();

        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(headers: {authorization: 'Bearer $refreshToken'}),
        );

        final accessToken = resp.data[Token_Key_Access];
        final options = err.requestOptions;

        options.headers.addAll({authorization: 'Bearer $accessToken'});
        await storage.write(key: Token_Key_Access, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
