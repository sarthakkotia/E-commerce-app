import 'package:ecommerce_app/common/loader.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealofDay();
  }

  void fetchDealofDay() async {
    logger.w("inside fetch deal of day function");
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
    logger.w("outside fetch deal of day function");
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      "Deal of the Day",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Image.network(
                    "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg",
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "\$100",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                      right: 40,
                    ),
                    child: const Text(
                      "Test",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ).copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "See all deals",
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  )
                ],
              );
  }
}
