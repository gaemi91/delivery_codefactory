import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRoute extends StatelessWidget {
  const RestaurantRoute({Key? key}) : super(key: key);

  Future<List> getRestaurantCard() async {
    final dio = Dio();
    final accessToken = await storage.read(key: Token_Key_Access);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {authorization: 'Bearer $accessToken'}),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getRestaurantCard(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final ModelRestaurant modelRestaurantCard =
                    ModelRestaurant.fromJson(json: snapshot.data![index]);

                return RestaurantCard.fromModel(
                  model: modelRestaurantCard,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20.0);
              },
              itemCount: 10,
            ),
          );
        });
  }
}
