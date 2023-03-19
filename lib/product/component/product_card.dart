import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/product/model/model_product.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail_product.dart';
import 'package:delivery_codefactory/user/provider/provider_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;
  final GestureTapCallback? onAddTap;
  final GestureTapCallback? onRemoveTap;

  const ProductCard({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
    this.onAddTap,
    this.onRemoveTap,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromModelRestaurantDetail({
    required ModelRestaurantDetailProduct model,
    GestureTapCallback? onAddTap,
    GestureTapCallback? onRemoveTap,
  }) {
    return ProductCard(
      id: model.id,
      name: model.name,
      imgUrl: model.imgUrl,
      detail: model.detail,
      price: model.price,
      onAddTap: onAddTap,
      onRemoveTap: onRemoveTap,
    );
  }

  factory ProductCard.fromModelProduct({
    required ModelProduct modelProduct,
    GestureTapCallback? onAddTap,
    GestureTapCallback? onRemoveTap,
  }) {
    return ProductCard(
      id: modelProduct.id,
      name: modelProduct.name,
      imgUrl: modelProduct.imgUrl,
      detail: modelProduct.detail,
      price: modelProduct.price,
      onAddTap: onAddTap,
      onRemoveTap: onRemoveTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateBasket = ref.watch(providerBasket);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(imgUrl, fit: BoxFit.cover, width: 110, height: 110),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      detail,
                      style: const TextStyle(color: Color_Text),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '₩${UtilsData.f.format(price)}',
                      style: const TextStyle(color: Color_Main),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        if (onAddTap != null && onRemoveTap != null)
          _Footer(
            price: (stateBasket.firstWhere((e) => e.product.id == id).product.price *
                    stateBasket.firstWhere((e) => e.product.id == id).count)
                .toString(),
            count: stateBasket.firstWhere((e) => e.product.id == id).count,
            onAddTap: onAddTap,
            onRemoveTap: onRemoveTap,
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String price;
  final int count;
  final GestureTapCallback? onAddTap;
  final GestureTapCallback? onRemoveTap;

  const _Footer({
    required this.price,
    required this.count,
    required this.onAddTap,
    required this.onRemoveTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '합계 ₩${UtilsData.f.format(int.parse(price))}',
            style: const TextStyle(color: Color_Main, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            renderIcon(iconData: Icons.remove, onTap: onRemoveTap),
            const SizedBox(width: 10.0),
            Text(
              '$count',
              style: const TextStyle(color: Color_Main, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10.0),
            renderIcon(iconData: Icons.add, onTap: onAddTap),
          ],
        )
      ],
    );
  }

  Widget renderIcon({
    required IconData iconData,
    required GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color_Main, width: 1.0),
        ),
        child: Icon(
          iconData,
          color: Color_Main,
        ),
      ),
    );
  }
}
