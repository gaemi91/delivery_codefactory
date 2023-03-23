import 'package:delivery_codefactory/common/route/route_common_pagination.dart';
import 'package:delivery_codefactory/order/component/order_card.dart';
import 'package:delivery_codefactory/order/model/model_order.dart';
import 'package:delivery_codefactory/order/provider/provider_order.dart';
import 'package:flutter/material.dart';

class RouteOrder extends StatelessWidget {

  const RouteOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouteCommonPagination<ModelOrder>(
      provider: providerOrder,
      builder: <ModelOrder>(_, index, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: OrderCard.fromModel(modelOrder: model),
        );
      },
    );
  }
}
