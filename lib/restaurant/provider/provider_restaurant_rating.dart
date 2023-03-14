import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateNotifierProviderRestaurantRating =
    StateNotifierProvider.family<StateNotifierRestaurantRating, CursorPaginationBase, String>((ref, id) =>
        StateNotifierRestaurantRating(repositoryRestaurantRating: ref.watch(providerRepositoryRestaurantRating(id))));

class StateNotifierRestaurantRating extends StateNotifier<CursorPaginationBase> {
  final RepositoryRestaurantRating repositoryRestaurantRating;

  StateNotifierRestaurantRating({required this.repositoryRestaurantRating}) : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate() {}
}
