// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_restaurant_detail_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRestaurantDetailProduct _$ModelRestaurantDetailProductFromJson(
        Map<String, dynamic> json) =>
    ModelRestaurantDetailProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: UtilsData.pathToUrl(json['imgUrl'] as String),
      detail: json['detail'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$ModelRestaurantDetailProductToJson(
        ModelRestaurantDetailProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'detail': instance.detail,
      'price': instance.price,
    };
