import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.address,
      required this.type,
      required this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  //TODO: understand why factory pattern used

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
