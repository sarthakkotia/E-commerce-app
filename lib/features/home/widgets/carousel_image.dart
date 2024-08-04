import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(
          builder: (context) => Image.network(
            i,
            fit: BoxFit.cover,
            height: 200,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        enableInfiniteScroll: true,
        height: 200,
      ),
    );
  }
}
