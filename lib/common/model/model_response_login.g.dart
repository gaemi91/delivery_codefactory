// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResponseLogIn _$ModelResponseLogInFromJson(Map<String, dynamic> json) =>
    ModelResponseLogIn(
      refreshToken: json['refreshToken'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$ModelResponseLogInToJson(ModelResponseLogIn instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };
