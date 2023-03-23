import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/order/model/model_order.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  const OrderCard({
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productsDetail,
    required this.price,
    Key? key,
  }) : super(key: key);

  factory OrderCard.fromModel({required ModelOrder modelOrder}) {
    final productsDetail = modelOrder.products.length < 2
        ? modelOrder.products.first.product.name
        : '${modelOrder.products.first.product.name} 외 ${modelOrder.products.length - 1}개';

    return OrderCard(
      orderDate: modelOrder.createdAt,
      image: Image.network(modelOrder.restaurant.thumbUrl, width: 50.0, height: 50.0, fit: BoxFit.cover),
      name: modelOrder.restaurant.name,
      productsDetail: productsDetail,
      price: modelOrder.totalPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} ${orderDate.hour.toString().padLeft(2, '0')}:${orderDate.minute.toString().padLeft(2, '0')} 결제완료'),
        const SizedBox(height: 5.0),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: image,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14.0)),
                Text(
                  '$productsDetail ${UtilsData.f.format(price)}원',
                  style: const TextStyle(color: Color_Text, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
