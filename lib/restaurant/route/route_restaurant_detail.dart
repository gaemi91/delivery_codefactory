import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/utils/utils_pagination.dart';
import 'package:delivery_codefactory/product/component/product_card.dart';
import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:delivery_codefactory/rating/component/rating_card.dart';
import 'package:delivery_codefactory/rating/model/model_rating.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_codefactory/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_codefactory/restaurant/provider/provider_restaurant_rating.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_basket.dart';
import 'package:delivery_codefactory/user/provider/provider_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';
import 'package:badges/badges.dart' as badges;

class RouteRestaurantDetail extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  final String id;

  const RouteRestaurantDetail({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<RouteRestaurantDetail> createState() => _RouteRestaurantDetailState();
}

class _RouteRestaurantDetailState extends ConsumerState<RouteRestaurantDetail> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(stateNotifierProviderRestaurant.notifier).getRestaurantDetail(id: widget.id);
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
      providerPagination: ref.read(stateNotifierProviderRestaurantRating(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateRestaurant = ref.watch(providerRestaurantDetail(widget.id));
    final stateRating = ref.watch(stateNotifierProviderRestaurantRating(widget.id));
    final stateBasket = ref.watch(providerBasket);

    if (stateRestaurant == null) {
      return const LayoutDefault(body: Center(child: CircularProgressIndicator()));
    }

    return LayoutDefault(
      title: stateRestaurant.name,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteRestaurantBasket.routeName);
        },
        backgroundColor: Color_Main,
        child: badges.Badge(
          showBadge: stateBasket.isNotEmpty,
          badgeContent: Text(
            stateBasket.fold<int>(0, (p, n) => p + n.count).toString(),
            style: const TextStyle(color: Color_Main, fontSize: 12.0),
          ),
          badgeStyle: const badges.BadgeStyle(badgeColor: Colors.white),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantCard.fromModel(
              model: stateRestaurant,
              isDetail: true,
            ),
          ),
          if (stateRestaurant is! ModelRestaurantDetail) renderLoading(),
          if (stateRestaurant is ModelRestaurantDetail)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '메뉴',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          if (stateRestaurant is ModelRestaurantDetail)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final products = stateRestaurant.products[index];

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 10.0 : 0),
                      child: InkWell(
                        onTap: () {
                          ref.read(providerBasket.notifier).addToBasket(
                                modelProduct: ModelProduct(
                                  id: products.id,
                                  restaurant: stateRestaurant,
                                  name: products.name,
                                  imgUrl: products.imgUrl,
                                  detail: products.detail,
                                  price: products.price,
                                ),
                              );
                        },
                        child: ProductCard.fromModelRestaurantDetail(model: products),
                      ),
                    );
                  },
                  childCount: stateRestaurant.products.length,
                ),
              ),
            ),
          if (stateRating is CursorPagination<ModelRating>)
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: stateRating.data.length,
                  (context, index) {
                    final modelRating = stateRating.data[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: index == stateRating.data.length - 1 ? 0 : 10.0),
                      child: RatingCard.fromModel(model: modelRating),
                    );
                  },
                ))),
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      sliver: SliverList(
          delegate: SliverChildListDelegate(
        [
          ...List.generate(
            4,
            (index) => const SkeletonLine(
              style: SkeletonLineStyle(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ...List.generate(
            5,
            (index) => SkeletonListTile(
              padding: const EdgeInsets.only(bottom: 10.0),
              hasSubtitle: true,
            ),
          ),
        ],
      )),
    );
  }
}
