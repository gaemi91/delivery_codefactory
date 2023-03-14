import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/repository/repository_pagination.dart';
import 'package:delivery_codefactory/rating/model/model_rating.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant_rating.g.dart';

final providerRepositoryRestaurantRating = Provider.family<RepositoryRestaurantRating, String>((ref, id) {
  final dio = ref.watch(providerDio);

  return RepositoryRestaurantRating(dio, baseUrl: 'http://$ip/restaurant/$id/rating');
});

@RestApi()
abstract class RepositoryRestaurantRating implements IRepositoryPagination<ModelRating> {
  factory RepositoryRestaurantRating(Dio dio, {String baseUrl}) = _RepositoryRestaurantRating;

  @override
  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<CursorPagination<ModelRating>> paginate({
    @Queries() ModelCursorPaginationMore? modelCursorPaginationMore = const ModelCursorPaginationMore(),
  });
}
