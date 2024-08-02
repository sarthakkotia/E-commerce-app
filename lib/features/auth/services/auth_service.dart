import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: "",
        email: email,
        name: name,
        password: password,
        address: "",
        type: "",
        token: "",
      );
      print("user created");
      Uri url = Uri.parse("$uri/api/signup");
      print("url is $url");
      // added string, string to tell the sever that the data coming is of type json in string
      //TODO: understand why to send this kind of content type
      String str = user.toJson();
      print(str);
      http.Response res = await http.post(
        url,
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                "Account Created! Please login with the same credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
