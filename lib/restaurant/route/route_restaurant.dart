import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantRouteMain extends StatelessWidget {
  const RestaurantRouteMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: RestaurantCard(
        image: Image.asset('asset/img/food/pizza_ddeok_bok_gi.jpg'),
        name: '피자 떡볶이',
        tags: ['매콤', '존맛탱', '혼자먹긔'],
        ratings: 4.55,
        ratingsCount: 50,
        deliveryTime: 20,
        deliveryFee: 4000,
      ),
    );
  }
}
