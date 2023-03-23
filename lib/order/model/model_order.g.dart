// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelOrder _$ModelOrderFromJson(Map<String, dynamic> json) => ModelOrder(
      id: json['id'] as String,
      restaurant:
          ModelRestaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => ModelOrderProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      createdAt: UtilsData.stringToDateTime(json['createdAt'] as String),
    );

Map<String, dynamic> _$ModelOrderToJson(ModelOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant': instance.restaurant,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt.toIso8601String(),
    };

ModelOrderProducts _$ModelOrderProductsFromJson(Map<String, dynamic> json) =>
    ModelOrderProducts(
      product:
          ModelOrderProduct.fromJson(json['product'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$ModelOrderProductsToJson(ModelOrderProducts instance) =>
    <String, dynamic>{
      'product': instance.product,
      'count': instance.count,
    };

ModelOrderProduct _$ModelOrderProductFromJson(Map<String, dynamic> json) =>
    ModelOrderProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: UtilsData.pathToUrl(json['imgUrl'] as String),
      price: json['price'] as int,
    );

Map<String, dynamic> _$ModelOrderProductToJson(ModelOrderProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
    };
