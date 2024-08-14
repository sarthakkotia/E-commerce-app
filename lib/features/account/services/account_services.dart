import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

var logger = Logger();

class AccountServices {
  Future<List<Product>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/orders/me"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      logger.w(res.statusCode);
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            logger.w(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
