// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert' show json;
import 'dart:convert';

import 'package:ecommerce_app/models/rating.dart';
// import 'package:logger/logger.dart';

// var logger = Logger();

class Product {
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id,
      this.rating});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    // logger.w(map);
    List<dynamic> imgs = map["images"];
    List<String> dummyimages = [];
    imgs.every(
      (element) {
        dummyimages.add(element);
        return true;
      },
    );
    List<dynamic> ratings = map["ratings"];
    return Product(
        name: map['name'] as String,
        description: map['description'] as String,
        quantity: map['quantity'] as int,
        images: dummyimages,
        category: map['category'] as String,
        price: double.parse("${map["price"]}"),
        id: map['_id'] != null ? map['_id'] as String : null,
        rating: ratings != null
            ? List<Rating>.from(
                map["ratings"]?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
