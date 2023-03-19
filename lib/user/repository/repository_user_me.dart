import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/user/model/model_basket.dart';
import 'package:delivery_codefactory/user/model/model_basket_body.dart';
import 'package:delivery_codefactory/user/model/model_user.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'repository_user_me.g.dart';

final providerRepositoryUserMe = Provider<RepositoryUserMe>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryUserMe(dio, baseUrl: 'http://$ip/user/me');
});

@RestApi()
abstract class RepositoryUserMe {
  factory RepositoryUserMe(Dio dio, {String baseUrl}) = _RepositoryUserMe;

  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<ModelUser> getUserMe();

  @GET('/basket')
  @Headers({Token_Key_Access: 'true'})
  Future<List<ModelBasket>> getBasket();

  @PATCH('/basket')
  @Headers({Token_Key_Access: 'true'})
  Future<List<ModelBasket>> patchBasket({@Body() required ModelBasketBody body});
}
