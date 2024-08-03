import 'dart:convert';

import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/home/screens/home_screen.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // print("user created");
      Uri url = Uri.parse("$uri/api/signup");
      // print("url is $url");
      // added string, string to tell the sever that the data coming is of type json in string
      //TODO: understand why to send this kind of content type
      // String str = user.toJson();
      // print(str);
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

  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      Uri url = Uri.parse("$uri/api/signin");
      http.Response res = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      // print(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          //save jwt in sharedprefs local
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);
          // state persistance using provider
          // TODO: under the predicate work here
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
          // showSnackBar(context,
          //     "Account Created! Please login with the same credentials");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", "");
      }
      http.Response tokenRes = await http.post(Uri.parse("$uri/isTokenValid"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
