import 'package:delivery_codefactory/common/route/route_common_pagination.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:flutter/material.dart';

class RouteRestaurant extends StatelessWidget {
  const RouteRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouteCommonPagination<ModelRestaurant>(
      provider: stateNotifierProviderRestaurant,
      builder: <ModelRestaurant>(context, index, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RouteRestaurantDetail(id: model.id);
              }));
            },
            child: RestaurantCard.fromModel(model: model),
          ),
        );
      },
    );
  }
}
