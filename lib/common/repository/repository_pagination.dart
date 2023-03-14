import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/model/model_with_id.dart';

abstract class IRepositoryPagination<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    ModelCursorPaginationMore? modelCursorPaginationMore = const ModelCursorPaginationMore(),
  });
}
