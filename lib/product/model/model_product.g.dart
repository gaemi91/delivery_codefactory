// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelProduct _$ModelProductFromJson(Map<String, dynamic> json) => ModelProduct(
      id: json['id'] as String,
      restaurant:
          ModelRestaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      name: json['name'] as String,
      imgUrl: UtilsData.pathToUrl(json['imgUrl'] as String),
      detail: json['detail'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$ModelProductToJson(ModelProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant': instance.restaurant,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'detail': instance.detail,
      'price': instance.price,
    };
