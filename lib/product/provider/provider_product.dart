import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:delivery_codefactory/product/repository/repository_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateNotifierProviderProduct = StateNotifierProvider<StateNotifierProduct, CursorPaginationBase>(
    (ref) => StateNotifierProduct(repository: ref.watch(providerRepositoryProduct)));

class StateNotifierProduct extends ProviderPagination<ModelProduct, RepositoryProduct> {
  StateNotifierProduct({required super.repository});
}
