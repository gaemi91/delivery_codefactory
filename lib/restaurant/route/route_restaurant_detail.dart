import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/product/component/product_card.dart';
import 'package:delivery_codefactory/rating/component/rating_card.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_codefactory/restaurant/provider/provider_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RouteRestaurantDetail extends ConsumerStatefulWidget {
  final String id;

  const RouteRestaurantDetail({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<RouteRestaurantDetail> createState() => _RouteRestaurantDetailState();
}

class _RouteRestaurantDetailState extends ConsumerState<RouteRestaurantDetail> {
  @override
  void initState() {
    super.initState();
    ref.read(stateNotifierProviderRestaurant.notifier).getRestaurantDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(providerRestaurantDetail(widget.id));

    if (data == null) {
      return const LayoutDefault(body: Center(child: CircularProgressIndicator()));
    }

    return LayoutDefault(
      title: data.name,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantCard.fromModel(
              model: data,
              isDetail: true,
            ),
          ),
          if (data is! ModelRestaurantDetail) renderLoading(),
          if (data is ModelRestaurantDetail)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '메뉴',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          if (data is ModelRestaurantDetail)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final products = data.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ProductCard.fromModel(model: products),
                    );
                  },
                  childCount: data.products.length,
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                avatarImage: AssetImage('asset/img/logo/codefactory_logo.png'),
                email: 'wannnnny@naver.com',
                rating: 4,
                content: 'sdjsldkfjsalkdfjsalkdfjalskdfaslkdflksjfsldkfjasldksadfasdfsdfsdfsfsfd',
                images: [
                  Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                  Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                  Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                  Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
                ],
              ),
            ),
          ),
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
