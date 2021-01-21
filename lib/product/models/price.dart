import 'dart:convert';

import 'package:equatable/equatable.dart';

class Price extends Equatable {
  Price({
    this.current,
    this.currency,
  });

  factory Price.fromJson(String source) =>
      Price.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Price.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Price(
      current: map['current'] as int,
      currency: map['currency'] as String,
    );
  }

  final int current;
  final String currency;

  Price copyWith({
    int current,
    String currency,
  }) {
    return Price(
      current: current ?? this.current,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current': current,
      'currency': currency,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [current, currency];
}
