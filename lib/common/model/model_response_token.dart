import 'package:json_annotation/json_annotation.dart';

part 'model_response_token.g.dart';

@JsonSerializable()
class ModelResponseToken {
  final String accessToken;

  ModelResponseToken({required this.accessToken});

  factory ModelResponseToken.fromJson(Map<String, dynamic> json) => _$ModelResponseTokenFromJson(json);
}
