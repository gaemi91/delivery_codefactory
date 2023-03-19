import 'package:json_annotation/json_annotation.dart';

part 'model_basket_body.g.dart';

@JsonSerializable()
class ModelBasketBody {
  final List<ModelBasketBodyRequest> basket;

  ModelBasketBody({required this.basket});

  factory ModelBasketBody.fromJson(Map<String, dynamic> json) => _$ModelBasketBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ModelBasketBodyToJson(this);
}

@JsonSerializable()
class ModelBasketBodyRequest {
  final String productId;
  final int count;

  ModelBasketBodyRequest({required this.productId, required this.count});

  factory ModelBasketBodyRequest.fromJson(Map<String, dynamic> json) => _$ModelBasketBodyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ModelBasketBodyRequestToJson(this);
}
