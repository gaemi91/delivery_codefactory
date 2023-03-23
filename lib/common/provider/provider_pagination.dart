import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/model/model_with_id.dart';
import 'package:delivery_codefactory/common/repository/repository_pagination.dart';
import 'package:delivery_codefactory/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debounce_throttle/debounce_throttle.dart';

class _PaginationInfo {
  final int countFetch;
  final bool fetchMore;
  final bool forceRefetch;

  _PaginationInfo({
    this.countFetch = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

abstract class ProviderPagination<T extends IModelWithId, U extends IRepositoryPagination<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  final throttlePagination = Throttle(
    const Duration(seconds: 3),
    initialValue: _PaginationInfo(),
    checkEquality: false,
  );

  ProviderPagination({required this.repository}) : super(CursorPaginationLoading()) {
    paginate();
    throttlePagination.values.listen((state) {
      _throttlePagination(state);
    });
  }

  _throttlePagination(_PaginationInfo info) async {
    final countFetch = info.countFetch;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;

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
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchMore<T>(meta: pState.meta, data: pState.data);

        modelCursorPaginationMore = modelCursorPaginationMore.copyWith(after: pState.data.last.id);
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefresh<T>(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(modelCursorPaginationMore: modelCursorPaginationMore);

      if (state is CursorPaginationFetchMore) {
        final pState = state as CursorPaginationFetchMore<T>;

        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      logger.wtf(e);
      logger.wtf(stack);
      state = CursorPaginationError(message: '데이터를 불러올 수 없습니다.');
    }
  }

  Future<void> paginate({
    int countFetch = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    throttlePagination.setValue(_PaginationInfo(
      forceRefetch: forceRefetch,
      fetchMore: fetchMore,
      countFetch: countFetch,
    ));
  }
}
