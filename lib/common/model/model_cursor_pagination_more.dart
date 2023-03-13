import 'package:json_annotation/json_annotation.dart';

part 'model_cursor_pagination_more.g.dart';

@JsonSerializable()
class ModelCursorPaginationMore {
  final String? after;
  final int? count;

  const ModelCursorPaginationMore({ this.after,  this.count});

  factory ModelCursorPaginationMore.fromJson(Map<String, dynamic> json) => _$ModelCursorPaginationMoreFromJson(json);

  Map<String, dynamic> toJson() => _$ModelCursorPaginationMoreToJson(this);

  ModelCursorPaginationMore copyWith({String? after, int? count}) {
    return ModelCursorPaginationMore(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }
}
