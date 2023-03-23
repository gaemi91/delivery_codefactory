import 'package:delivery_codefactory/common/model/model_with_id.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_order.g.dart';

@JsonSerializable()
class ModelOrder implements IModelWithId {
  @override
  final String id;
  final ModelRestaurant restaurant;
  final List<ModelOrderProducts> products;
  final int totalPrice;
  @JsonKey(fromJson: UtilsData.stringToDateTime)
  final DateTime createdAt;

  ModelOrder({
    required this.id,
    required this.restaurant,
    required this.products,
    required this.totalPrice,
    required this.createdAt,
  });

  factory ModelOrder.fromJson(Map<String, dynamic> json) => _$ModelOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ModelOrderToJson(this);
}

@JsonSerializable()
class ModelOrderProducts {
  final ModelOrderProduct product;
  final int count;

  ModelOrderProducts({
    required this.product,
    required this.count,
  });

  factory ModelOrderProducts.fromJson(Map<String, dynamic> json) => _$ModelOrderProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ModelOrderProductsToJson(this);
}

@JsonSerializable()
class ModelOrderProduct {
  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: UtilsData.pathToUrl)
  final String imgUrl;
  final int price;

  ModelOrderProduct({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory ModelOrderProduct.fromJson(Map<String, dynamic> json) => _$ModelOrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$ModelOrderProductToJson(this);
}
