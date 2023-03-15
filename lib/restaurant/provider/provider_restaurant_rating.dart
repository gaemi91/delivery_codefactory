import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:delivery_codefactory/rating/model/model_rating.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateNotifierProviderRestaurantRating =
    StateNotifierProvider.family<StateNotifierRestaurantRating, CursorPaginationBase, String>(
        (ref, id) => StateNotifierRestaurantRating(repository: ref.watch(providerRepositoryRestaurantRating(id))));

class StateNotifierRestaurantRating extends ProviderPagination<ModelRating, RepositoryRestaurantRating> {
  StateNotifierRestaurantRating({required super.repository});
}
