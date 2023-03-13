import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

final providerRepositoryRestaurant = Provider<RepositoryRestaurant>((ref) {
  final dio = ref.watch(providerDio);
  final repository = RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant');

  return repository;
});

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<CursorPagination<ModelRestaurant>> paginate({
    @Queries() ModelCursorPaginationMore? modelCursorPaginationMore = const ModelCursorPaginationMore(),
  });

  @GET('/{id}')
  @Headers({Token_Key_Access: 'true'})
  Future<ModelRestaurantDetail> getRestaurantDetail({
    @Path() required String id,
  });
}
