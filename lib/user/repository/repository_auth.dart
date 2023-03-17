import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/common/model/model_response_login.dart';
import 'package:delivery_codefactory/common/model/model_response_token.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRepositoryAuth = Provider<RepositoryAuth>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryAuth(dio: dio, baseUrl: 'http://$ip/auth');
});

class RepositoryAuth {
  final Dio dio;
  final String baseUrl;

  RepositoryAuth({required this.dio, required this.baseUrl});

  Future<ModelResponseLogIn> logIn({
    required String username,
    required String password,
  }) async {
    final token = UtilsData.valueToBase64('$username:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(headers: {authorization: 'Basic $token'}),
    );

    return ModelResponseLogIn.fromJson(resp.data);
  }

  Future<ModelResponseToken> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {Token_Key_Refresh: 'true'}),
    );

    return ModelResponseToken.fromJson(resp.data);
  }
}
