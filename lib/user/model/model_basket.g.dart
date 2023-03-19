// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_basket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBasket _$ModelBasketFromJson(Map<String, dynamic> json) => ModelBasket(
      product: ModelProduct.fromJson(json['product'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$ModelBasketToJson(ModelBasket instance) =>
    <String, dynamic>{
      'product': instance.product,
      'count': instance.count,
    };
