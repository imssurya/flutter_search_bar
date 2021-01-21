import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lastResearch/product/models/price.dart';

class Variant extends Equatable {
  Variant({
    this.code,
    this.name,
    this.available,
    this.price,
  });

  factory Variant.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Variant(
      code: map['code'] as String,
      name: map['name'] as String,
      available: map['available'] as bool,
      price: Price.fromMap(map['price'] as Map<String, dynamic>),
    );
  }

  factory Variant.fromJson(String source) =>
      Variant.fromMap(json.decode(source) as Map<String, dynamic>);

  final String code;
  final String name;
  final bool available;
  final Price price;

  Variant copyWith({
    String code,
    String name,
    bool available,
    Price price,
  }) {
    return Variant(
      code: code ?? this.code,
      name: name ?? this.name,
      available: available ?? this.available,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'available': available,
      'price': price,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, name, available, price];
}
