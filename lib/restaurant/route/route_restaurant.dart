import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/utils/utils_pagination.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteRestaurant extends ConsumerStatefulWidget {
  const RouteRestaurant({Key? key}) : super(key: key);

  @override
  ConsumerState<RouteRestaurant> createState() => _RouteRestaurantState();
}

class _RouteRestaurantState extends ConsumerState<RouteRestaurant> {
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
      providerPagination: ref.read(stateNotifierProviderRestaurant.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(stateNotifierProviderRestaurant);

    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    final cursorPagination = data as CursorPagination;

    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == cursorPagination.data.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
                child: data is CursorPaginationFetchMore
                    ? const CircularProgressIndicator()
                    : const Text('데이터가 더이상 없습니다.')),
          );
        }

        final modelRestaurant = cursorPagination.data[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RouteRestaurantDetail(
                  id: modelRestaurant.id,
                );
              }));
            },
            child: RestaurantCard.fromModel(model: modelRestaurant),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: cursorPagination.data.length + 1,
    );
  }
}
