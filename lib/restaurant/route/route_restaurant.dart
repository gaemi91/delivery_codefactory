import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/restaurant/component/restaurant_card.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/repository/repository_restaurant.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RouteRestaurant extends StatelessWidget {
  const RouteRestaurant({Key? key}) : super(key: key);

  Future<List<ModelRestaurant>> paginate() async {
    final dio = Dio();

    dio.interceptors.add(CustomInterceptor());

    final repository = await RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return repository.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelRestaurant>>(
        future: paginate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final modelRestaurant = snapshot.data![index];

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
