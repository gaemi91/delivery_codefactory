import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_user.g.dart';

abstract class ModelUserBase {}

class ModelUserLoading extends ModelUserBase {}

class ModelUserError extends ModelUserBase {
  final String message;

  ModelUserError({required this.message});
}

@JsonSerializable()
class ModelUser extends ModelUserBase {
  final String id;
  final String username;
  @JsonKey(fromJson: UtilsData.pathToUrl)
  final String imageUrl;

  ModelUser({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => _$ModelUserFromJson(json);

  Map<String, dynamic> toJson() => _$ModelUserToJson(this);
}
