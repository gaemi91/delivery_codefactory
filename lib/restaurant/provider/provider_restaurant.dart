import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRestaurantDetail = Provider.family<ModelRestaurant?, String>((ref, id) {
  final state = ref.watch(stateNotifierProviderRestaurant);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhere((e) => e.id == id);
});

final stateNotifierProviderRestaurant = StateNotifierProvider<StateNotifierRestaurant, CursorPaginationBase>(
    (ref) => StateNotifierRestaurant(repository: ref.watch(providerRepositoryRestaurant)));

class StateNotifierRestaurant extends ProviderPagination<ModelRestaurant, RepositoryRestaurant> {
  StateNotifierRestaurant({required super.repository});

  void getRestaurantDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(data: pState.data.map<ModelRestaurant>((e) => e.id == id ? resp : e).toList());
  }
}
