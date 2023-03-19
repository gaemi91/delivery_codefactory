// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_basket_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBasketBody _$ModelBasketBodyFromJson(Map<String, dynamic> json) =>
    ModelBasketBody(
      basket: (json['basket'] as List<dynamic>)
          .map(
              (e) => ModelBasketBodyRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelBasketBodyToJson(ModelBasketBody instance) =>
    <String, dynamic>{
      'basket': instance.basket,
    };

ModelBasketBodyRequest _$ModelBasketBodyRequestFromJson(
        Map<String, dynamic> json) =>
    ModelBasketBodyRequest(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$ModelBasketBodyRequestToJson(
        ModelBasketBodyRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
