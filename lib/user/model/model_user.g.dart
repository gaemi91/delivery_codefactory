// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUser _$ModelUserFromJson(Map<String, dynamic> json) => ModelUser(
      id: json['id'] as String,
      username: json['username'] as String,
      imageUrl: UtilsData.pathToUrl(json['imageUrl'] as String),
    );

Map<String, dynamic> _$ModelUserToJson(ModelUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
    };
