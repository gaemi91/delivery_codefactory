import 'package:delivery_codefactory/common/route/route_common_pagination.dart';
import 'package:delivery_codefactory/product/component/product_card.dart';
import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:delivery_codefactory/product/provider/provider_product.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:flutter/material.dart';

class RouteProduct extends StatelessWidget {
  const RouteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouteCommonPagination<ModelProduct>(
      provider: stateNotifierProviderProduct,
      builder: <ModelProduct>(context, index, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RouteRestaurantDetail(id: model.restaurant.id);
              }));
            },
            child: ProductCard.fromModel(model: model),
          ),
        );
      },
    );
  }
}
