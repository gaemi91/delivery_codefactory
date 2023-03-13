import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail_product.dart';

class ModelRestaurantDetail extends ModelRestaurant {
  final String detail;
  final List<ModelRestaurantDetailProduct> products;

  ModelRestaurantDetail({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory ModelRestaurantDetail.fromJson({required Map<String, dynamic> json}) {
    return ModelRestaurantDetail(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List.from(json['tags']),
      priceRange: PriceRange.values.firstWhere((e) => e.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products']
          .map<ModelRestaurantDetailProduct>((e) => ModelRestaurantDetailProduct.fromJson(json: e))
          .toList(),
    );
  }
}
