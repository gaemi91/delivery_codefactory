import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/product/component/product_card.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteRestaurantDetail extends ConsumerStatefulWidget {
  final String id;

  const RouteRestaurantDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RouteRestaurantDetail> createState() => _RouteRestaurantDetailState();
}

class _RouteRestaurantDetailState extends ConsumerState<RouteRestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelRestaurantDetail>(
        future: ref.watch(providerRepositoryRestaurant).getRestaurantDetail(id: widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final items = snapshot.data!;

          return LayoutDefault(
            title: items.name,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: RestaurantCard.fromModel(
                    model: items,
                    isDetail: true,
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      '메뉴',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final products = items.products[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ProductCard.fromModel(model: products),
                        );
                      },
                      childCount: items.products.length,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
