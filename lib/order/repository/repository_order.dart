import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/repository/repository_pagination.dart';
import 'package:delivery_codefactory/order/model/model_order.dart';
import 'package:delivery_codefactory/order/model/model_order_body.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'repository_order.g.dart';

final providerRepositoryOrder = Provider<RepositoryOrder>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryOrder(dio, baseUrl: 'http://$ip/order');
});

@RestApi()
abstract class RepositoryOrder implements IRepositoryPagination<ModelOrder> {
  factory RepositoryOrder(Dio dio, {String baseUrl}) = _RepositoryOrder;

  @override
  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<CursorPagination<ModelOrder>> paginate({
    @Queries() ModelCursorPaginationMore? modelCursorPaginationMore = const ModelCursorPaginationMore(),
  });

  @POST('/')
  @Headers({Token_Key_Access: 'true'})
  Future<ModelOrder> postOrder({@Body() required ModelOrderBody body});
}
