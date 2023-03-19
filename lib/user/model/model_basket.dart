import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_basket.g.dart';

@JsonSerializable()
class ModelBasket {
  final ModelProduct product;
  final int count;

  ModelBasket({required this.product, required this.count});

  factory ModelBasket.fromJson(Map<String, dynamic> json) => _$ModelBasketFromJson(json);

  Map<String, dynamic> toJson() => _$ModelBasketToJson(this);

  ModelBasket copyWith({ModelProduct? product, int? count}) {
    return ModelBasket(
      product: product ?? this.product,
      count: count ?? this.count,
    );
  }
}
