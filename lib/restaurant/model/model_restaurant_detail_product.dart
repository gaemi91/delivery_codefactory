import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_restaurant_detail_product.g.dart';

@JsonSerializable()
class ModelRestaurantDetailProduct {
  final String id;
  final String name;
  @JsonKey(fromJson: UtilsData.pathToUrl)
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

  factory ModelRestaurantDetailProduct.fromJson(Map<String, dynamic> json) =>
      _$ModelRestaurantDetailProductFromJson(json);

  Map<String, dynamic> toJson() => _$ModelRestaurantDetailProductToJson(this);
}
