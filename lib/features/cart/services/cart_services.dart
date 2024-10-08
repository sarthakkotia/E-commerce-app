import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // use the delete method
      http.Response res = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            // instead of updating the whole whole which could cause problems with provider we used copyWith constructor
            // logger.w(jsonDecode(res.body)['changed']['cart']);
            User user = userProvider.user
                .copyWith(cart: jsonDecode(res.body)['changed']['cart']);
            // now set user to a different one
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      // logger.w(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
