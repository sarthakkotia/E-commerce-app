import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    // logger.w(user.cart);
    int sum = 0;
    user.cart.map((e) {
      // logger.w(e);
      sum += e['quantity'] * e['product']['price'] as int;
      // logger.w(sum);
    }).toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal ",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "\$$sum",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
