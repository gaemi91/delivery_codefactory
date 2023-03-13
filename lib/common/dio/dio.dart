import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/main.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
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
