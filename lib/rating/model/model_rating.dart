import 'package:delivery_codefactory/common/model/model_with_id.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/user/model/model_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_rating.g.dart';

@JsonSerializable()
class ModelRating implements IModelWithId {
  @override
  final String id;
  final ModelUser user;
  final int rating;
  final String content;
  @JsonKey(fromJson: UtilsData.listPathToUrl)
  final List<String> imgUrls;

  ModelRating({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
  });

  factory ModelRating.fromJson(Map<String, dynamic> json) => _$ModelRatingFromJson(json);

  Map<String, dynamic> toJson() => _$ModelRatingToJson(this);
}
