import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/api/products/rate-product"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": userProvider.token
              },
              body: jsonEncode({"id": product.id, "rating": rating}));
      httpErrorHandler(response: res, context: context, onSuccess: () {});
    } catch (e) {
      logger.w(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
