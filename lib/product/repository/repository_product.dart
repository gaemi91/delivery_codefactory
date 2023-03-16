import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/dio/dio.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_codefactory/common/repository/repository_pagination.dart';
import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_product.g.dart';

final providerRepositoryProduct = Provider<RepositoryProduct>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryProduct(dio, baseUrl: 'http://$ip/product');
});

@RestApi()
abstract class RepositoryProduct implements IRepositoryPagination<ModelProduct> {
  factory RepositoryProduct(Dio dio, {String baseUrl}) = _RepositoryProduct;

  @override
  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<CursorPagination<ModelProduct>> paginate({
    @Queries() ModelCursorPaginationMore? modelCursorPaginationMore = const ModelCursorPaginationMore(),
  });
}
