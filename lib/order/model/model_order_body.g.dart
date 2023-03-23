// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_order_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelOrderBody _$ModelOrderBodyFromJson(Map<String, dynamic> json) =>
    ModelOrderBody(
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map(
              (e) => ModelOrderBodyProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ModelOrderBodyToJson(ModelOrderBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
    };

ModelOrderBodyProducts _$ModelOrderBodyProductsFromJson(
        Map<String, dynamic> json) =>
    ModelOrderBodyProducts(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$ModelOrderBodyProductsToJson(
        ModelOrderBodyProducts instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
