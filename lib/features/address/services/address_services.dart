import 'dart:convert';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({"address": address}),
      );
      logger.w(res.statusCode);
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            logger.w("it should work till here");
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": userProvider.user.token
          },
          body: jsonEncode({
            "cart": userProvider.user.cart,
            "address": address,
            "totalPrice": totalSum
          }));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
          showSnackBar(context, "Your Order has been placed");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
