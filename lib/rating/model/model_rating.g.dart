// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRating _$ModelRatingFromJson(Map<String, dynamic> json) => ModelRating(
      id: json['id'] as String,
      user: ModelUser.fromJson(json['user'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      content: json['content'] as String,
      imgUrls: UtilsData.listPathToUrl(json['imgUrls'] as List),
    );

Map<String, dynamic> _$ModelRatingToJson(ModelRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'rating': instance.rating,
      'content': instance.content,
      'imgUrls': instance.imgUrls,
    };
