import 'package:flutter/material.dart';

class RatingProduct extends StatelessWidget {
  const RatingProduct({
    super.key,
    this.starcount = 5,
    this.rating = 0,
    this.color,
  });

  final int starcount;
  final double rating;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starcount,
        (index) => _starRating(context, index),
      ),
    );
  }

  Widget _starRating(context, int index) {
    if (index >= rating) {
      return const Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 18,
      );
    } else if (index > rating - 1 && index < rating) {
      return Icon(
        Icons.star_half,
        color: color ?? Colors.amber,
        size: 18,
      );
    } else {
      return Icon(
        Icons.star,
        color: color ?? Colors.amber,
        size: 18,
      );
    }
  }
}
