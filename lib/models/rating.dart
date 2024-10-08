import 'dart:convert';

// import 'package:logger/logger.dart';

// var logger = Logger();

class Rating {
  final String userId;
  final double rating;

  Rating({required this.userId, required this.rating});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] as String,
      rating: double.parse("${map["rating"]}"),
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);
}
