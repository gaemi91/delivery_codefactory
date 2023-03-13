import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  @GET('/{id}')
  @Headers({Token_Key_Access: 'true'})
  Future<ModelRestaurantDetail> getRestaurantDetail({
    @Path() required String id,
  });
}
