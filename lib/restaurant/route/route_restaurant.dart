import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteRestaurant extends ConsumerStatefulWidget {
  const RouteRestaurant({Key? key}) : super(key: key);

  @override
  ConsumerState<RouteRestaurant> createState() => _RouteRestaurantState();
}

class _RouteRestaurantState extends ConsumerState<RouteRestaurant> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CursorPagination<ModelRestaurant>>(
        future: ref.watch(providerRepositoryRestaurant).paginate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final modelRestaurant = snapshot.data!.data[index];

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
            itemCount: snapshot.data!.data.length,
          );
        });
  }
}
