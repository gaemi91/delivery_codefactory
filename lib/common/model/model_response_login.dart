import 'package:json_annotation/json_annotation.dart';

part 'model_response_login.g.dart';

@JsonSerializable()
class ModelResponseLogIn {
  final String refreshToken;
  final String accessToken;

  ModelResponseLogIn({required this.refreshToken, required this.accessToken});

  factory ModelResponseLogIn.fromJson(Map<String, dynamic> json) => _$ModelResponseLogInFromJson(json);
}
