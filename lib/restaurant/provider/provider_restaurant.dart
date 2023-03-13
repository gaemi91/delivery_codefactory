import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
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
    (ref) => StateNotifierRestaurant(repositoryRestaurant: ref.watch(providerRepositoryRestaurant)));

class StateNotifierRestaurant extends StateNotifier<CursorPaginationBase> {
  final RepositoryRestaurant repositoryRestaurant;

  StateNotifierRestaurant({required this.repositoryRestaurant}) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int countFetch = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isFetchMore = state is CursorPaginationFetchMore;
      final isRefresh = state is CursorPaginationRefresh;

      if (fetchMore && (isLoading || isFetchMore || isRefresh)) {
        return;
      }

      ModelCursorPaginationMore modelCursorPaginationMore = ModelCursorPaginationMore(count: countFetch);

      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchMore(meta: pState.meta, data: pState.data);

        modelCursorPaginationMore = modelCursorPaginationMore.copyWith(after: pState.data.last.id);
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationRefresh(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repositoryRestaurant.paginate(modelCursorPaginationMore: modelCursorPaginationMore);

      if (state is CursorPaginationFetchMore) {
        final pState = state as CursorPaginationFetchMore;

        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 불러올 수 없습니다.');
    }
  }

  void getRestaurantDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repositoryRestaurant.getRestaurantDetail(id: id);

    state = pState.copyWith(data: pState.data.map<ModelRestaurant>((e) => e.id == id ? resp : e).toList());
  }
}
