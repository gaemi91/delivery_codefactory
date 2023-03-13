import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RouteRestaurant extends StatelessWidget {
  const RouteRestaurant({Key? key}) : super(key: key);

  Future<List> paginate() async {
    final dio = Dio();
    final accessToken = await storage.read(key: Token_Key_Access);

    dio.interceptors.add(CustomInterceptor());

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: paginate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final listItems = snapshot.data![index];
              final ModelRestaurant modelRestaurant = ModelRestaurant.fromJson(listItems);

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
            itemCount: snapshot.data!.length,
          );
        });
  }
}
