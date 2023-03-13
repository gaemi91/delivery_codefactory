import 'package:delivery_codefactory/common/const/data.dart';

enum PriceRange {
  expensive,
  medium,
  cheap,
}

class ModelRestaurant {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final PriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  ModelRestaurant({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory ModelRestaurant.fromJson({required Map<String, dynamic> json}) {
    return ModelRestaurant(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List.from(json['tags']),
      priceRange: PriceRange.values.firstWhere((e) => e.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
