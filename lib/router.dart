import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/features/admin/screens/add_product_screen.dart';
import 'package:ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_app/features/home/screens/category_deals_screen.dart';
import 'package:ecommerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) {
          return const AuthScreen();
        },
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) {
          return const HomeScreen();
        },
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) {
          return const BottomBar();
        },
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) {
          return const AddProductScreen();
        },
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) {
          return CategoryDealsScreen(
            category: category,
          );
        },
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Scrren Does Not Exist"),
          ),
        ),
      );
  }
}
