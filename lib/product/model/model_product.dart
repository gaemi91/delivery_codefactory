import 'package:delivery_codefactory/common/model/model_with_id.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_product.g.dart';

@JsonSerializable()
class ModelProduct implements IModelWithId {
  @override
  final String id;
  final ModelRestaurant restaurant;
  final String name;
  @JsonKey(fromJson: UtilsData.pathToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  ModelProduct({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) => _$ModelProductFromJson(json);
}
