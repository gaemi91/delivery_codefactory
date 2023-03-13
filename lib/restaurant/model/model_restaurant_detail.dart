import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail_product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_restaurant_detail.g.dart';

@JsonSerializable()
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

  factory ModelRestaurantDetail.fromJson(Map<String, dynamic> json) => _$ModelRestaurantDetailFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ModelRestaurantDetailToJson(this);
}
