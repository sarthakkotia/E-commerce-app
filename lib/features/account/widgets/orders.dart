import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/account/widgets/product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //temporary list
  List list = [
    {
      "image":
          "https://images.pexels.com/photos/27302823/pexels-photo-27302823/free-photo-of-blueberries-on-and-near-plate.jpeg",
    },
    {
      "image":
          "https://images.pexels.com/photos/27302823/pexels-photo-27302823/free-photo-of-blueberries-on-and-near-plate.jpeg",
    },
    {
      "image":
          "https://images.pexels.com/photos/27302823/pexels-photo-27302823/free-photo-of-blueberries-on-and-near-plate.jpeg",
    },
    {
      "image":
          "https://images.pexels.com/photos/27302823/pexels-photo-27302823/free-photo-of-blueberries-on-and-near-plate.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See All",
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Product(image: list[index]["image"]);
            },
          ),
        )
      ],
    );
  }
}
