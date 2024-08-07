import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    //view only widget
    return RatingBarIndicator(
      itemSize: 28,
      direction: Axis.horizontal,
      itemCount: 5, // number of stars
      rating: rating, // actul rating
      itemBuilder: (context, _) {
        return const Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
