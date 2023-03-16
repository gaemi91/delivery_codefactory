import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_with_id.dart';
import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:delivery_codefactory/common/utils/utils_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(BuildContext context, int index, T model);

class RouteCommonPagination<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProviderPagination, CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> builder;

  const RouteCommonPagination({
    required this.provider,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RouteCommonPagination> createState() => _RouteCommonPaginationState<T>();
}

class _RouteCommonPaginationState<T extends IModelWithId> extends ConsumerState<RouteCommonPagination> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    UtilsPagination.paginate(
      scrollController: scrollController,
      providerPagination: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.message, textAlign: TextAlign.center),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color_Main),
            child: const Text('다시 시도'),
          )
        ],
      );
    }

    final cursorPaginationModel = state as CursorPagination<T>;

    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == cursorPaginationModel.data.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Center(
                child: state is CursorPaginationFetchMore
                    ? const CircularProgressIndicator()
                    : const Text('데이터가 더이상 없습니다.')),
          );
        }

        final T model = cursorPaginationModel.data[index];

        return widget.builder(context, index, model);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: cursorPaginationModel.data.length + 1,
    );
  }
}
