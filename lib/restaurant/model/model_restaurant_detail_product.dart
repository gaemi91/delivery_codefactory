import 'package:delivery_codefactory/common/const/data.dart';

class ModelRestaurantDetailProduct {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  ModelRestaurantDetailProduct({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ModelRestaurantDetailProduct.fromJson({required Map<String, dynamic> json}) {
    return ModelRestaurantDetailProduct(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$ip${json['imgUrl']}',
      detail: json['detail'],
      price: json['price'],
    );
  }
}
