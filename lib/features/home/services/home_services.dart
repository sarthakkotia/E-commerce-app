import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)["products"].length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)["products"][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product?> fetchDealOfTheDay({required BuildContext context}) async {
    Product p = Product(
        name: "",
        description: "",
        quantity: 0,
        images: [],
        category: "",
        price: 0);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      logger.w(jsonDecode(res.body));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            p = Product.fromJson(jsonDecode(res.body)["product"]);
            // p = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return p;
  }
}
