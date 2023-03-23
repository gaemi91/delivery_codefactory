import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:delivery_codefactory/user/model/model_basket.dart';
import 'package:delivery_codefactory/user/model/model_basket_body.dart';
import 'package:delivery_codefactory/user/repository/repository_user_me.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:collection/collection.dart';

final providerBasket = StateNotifierProvider<ProviderBasket, List<ModelBasket>>((ref) {
  final repositoryUserMe = ref.watch(providerRepositoryUserMe);

  return ProviderBasket(repositoryUserMe: repositoryUserMe);
});

class ProviderBasket extends StateNotifier<List<ModelBasket>> {
  final RepositoryUserMe repositoryUserMe;
  final debounceBasket = Debouncer(const Duration(seconds: 1), initialValue: null, checkEquality: false);

  ProviderBasket({required this.repositoryUserMe}) : super([]) {
    debounceBasket.values.listen((event) {
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    await repositoryUserMe.patchBasket(
        body: ModelBasketBody(
            basket: state
                .map(
                  (e) => ModelBasketBodyRequest(
                    productId: e.product.id,
                    count: e.count,
                  ),
                )
                .toList()));
  }

  Future<void> addToBasket({required ModelProduct modelProduct}) async {
    final exists = state.firstWhereOrNull((e) => e.product.id == modelProduct.id) != null;

    if (exists) {
      state = state
          .map((e) => e.product.id == modelProduct.id
              ? e.copyWith(
                  count: e.count + 1,
                )
              : e)
          .toList();
    } else {
      state = [
        ...state,
        ModelBasket(product: modelProduct, count: 1),
      ];
    }
    debounceBasket.setValue(null);
  }

  Future<void> removeFromBasket({
    required ModelProduct modelProduct,
    bool isDelete = false,
  }) async {
    final exists = state.firstWhereOrNull((e) => e.product.id == modelProduct.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == modelProduct.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != modelProduct.id).toList();
    } else {
      state = state
          .map((e) => e.product.id == modelProduct.id
              ? e.copyWith(
                  count: e.count - 1,
                )
              : e)
          .toList();
    }
    debounceBasket.setValue(null);
  }
}
