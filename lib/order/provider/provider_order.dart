import 'package:delivery_codefactory/common/model/model_cursor_pagination.dart';
import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:delivery_codefactory/order/model/model_order.dart';
import 'package:delivery_codefactory/order/model/model_order_body.dart';
import 'package:delivery_codefactory/order/repository/repository_order.dart';
import 'package:delivery_codefactory/user/provider/provider_basket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final providerOrder = StateNotifierProvider<ProviderOrder, CursorPaginationBase>((ref) {
  final repository = ref.watch(providerRepositoryOrder);

  return ProviderOrder(ref: ref, repository: repository);
});

class ProviderOrder extends ProviderPagination<ModelOrder, RepositoryOrder> {
  final Ref ref;

  ProviderOrder({
    required this.ref,
    required super.repository,
  }) : super();

  Future<bool> postOrder() async {
    try {
      var uuid = const Uuid();

      final id = uuid.v4();

      final state = ref.read(providerBasket);

      await repository.postOrder(
        body: ModelOrderBody(
          id: id,
          products: state.map((e) => ModelOrderBodyProducts(productId: e.product.id, count: e.count)).toList(),
          totalPrice: state.fold<int>(0, (p, n) => p + (n.product.price * n.count)),
          createdAt: DateTime.now().toString(),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
