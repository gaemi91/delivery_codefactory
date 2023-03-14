import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/rating/model/model_rating.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;
  final String content;
  final List<Image> images;

  const RatingCard({
    required this.avatarImage,
    required this.email,
    required this.rating,
    required this.content,
    required this.images,
    Key? key,
  }) : super(key: key);

  factory RatingCard.fromModel({required ModelRating model}) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      email: model.user.username,
      rating: model.rating,
      content: model.content,
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(height: 5.0),
        _Body(content: content),
        const SizedBox(height: 5.0),
        SizedBox(height: 100, child: _Images(images: images)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header({
    required this.avatarImage,
    required this.email,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
          radius: 12.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(child: Text(email)),
        const SizedBox(width: 10.0),
        ...List.generate(
            5,
            (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border_outlined,
                  color: Color_Main,
                ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color_Text, fontSize: 14.0),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({required this.images, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(right: index == images.length - 1 ? 0 : 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: element,
              ),
            ),
          )
          .toList(),
    );
  }
}
