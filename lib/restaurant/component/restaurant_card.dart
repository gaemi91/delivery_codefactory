import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/utils/utils_data.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant.dart';
import 'package:delivery_codefactory/restaurant/model/model_restaurant_detail.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;
  final String? keyHero;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isDetail = false,
    this.detail,
    this.keyHero,
    Key? key,
  }) : super(key: key);

  factory RestaurantCard.fromModel({required ModelRestaurant model, bool isDetail = false}) {
    return RestaurantCard(
      image: Image.network(model.thumbUrl),
      name: model.name,
      tags: model.tags,
      ratings: model.ratings,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      detail: model is ModelRestaurantDetail ? model.detail : null,
      keyHero: model.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Hero(
          tag: ObjectKey(keyHero),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(isDetail ? 0 : 8.0)),
            child: image,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 10.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2.0),
              Text(tags.join(" · "), style: const TextStyle(color: Color_Text, fontSize: 15.0)),
              const SizedBox(height: 2.0),
              Row(
                children: [
                  _IconData(iconData: Icons.star, label: '$ratings'),
                  renderDot(),
                  _IconData(iconData: Icons.receipt, label: '$ratingsCount'),
                  renderDot(),
                  _IconData(iconData: Icons.timelapse, label: '$deliveryTime분'),
                  renderDot(),
                  _IconData(
                    iconData: Icons.monetization_on,
                    label: deliveryFee == 0 ? '무료' : '${UtilsData.f.format(deliveryFee)}원',
                  ),
                ],
              ),
              if (isDetail && detail != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(detail!),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: Text(' · ',
          style: TextStyle(
            color: Color_Main,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}

class _IconData extends StatelessWidget {
  final IconData iconData;
  final String label;

  const _IconData({
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Color_Main, size: 15.0),
        const SizedBox(width: 3.0),
        Text(label, style: const TextStyle(color: Color_Main, fontSize: 14.0)),
      ],
    );
  }
}
