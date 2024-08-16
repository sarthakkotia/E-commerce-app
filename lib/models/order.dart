// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/models/product.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order(
      {required this.id,
      required this.products,
      required this.quantity,
      required this.address,
      required this.userId,
      required this.orderedAt,
      required this.status,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as int,
      status: map['status'] as int,
      totalPrice: double.parse(map['totalPrice'].toString()),
      quantity: List<int>.from(
        map['products']?.map(
          (e) => e['quantity'],
        ),
      ),
      products: List<Product>.from(
        map['products']?.map(
          (e) => Product.fromMap(
            e['product'],
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) {
    // logger.w(source);
    return Order.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
