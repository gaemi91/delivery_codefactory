import 'package:json_annotation/json_annotation.dart';

part 'model_order_body.g.dart';

@JsonSerializable()
class ModelOrderBody {
  final String id;
  final List<ModelOrderBodyProducts> products;
  final int totalPrice;
  final String createdAt;

  ModelOrderBody({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.createdAt,
  });

  factory ModelOrderBody.fromJson(Map<String, dynamic> json) => _$ModelOrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ModelOrderBodyToJson(this);
}

@JsonSerializable()
class ModelOrderBodyProducts {
  final String productId;
  final int count;

  ModelOrderBodyProducts({
    required this.productId,
    required this.count,
  });

  factory ModelOrderBodyProducts.fromJson(Map<String, dynamic> json) => _$ModelOrderBodyProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ModelOrderBodyProductsToJson(this);
}
