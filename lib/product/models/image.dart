import 'dart:convert';

import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({
    this.code,
    this.path,
    this.cachedPath,
  });

  factory Image.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Image(
      code: map['code'] as String,
      path: map['path'] as String,
      cachedPath: map['cachedPath'] as String,
    );
  }

  factory Image.fromJson(String source) =>
      Image.fromMap(json.decode(source) as Map<String, dynamic>);

  final String code;
  final String path;
  final String cachedPath;

  Image copyWith({
    String code,
    String path,
    String cachedPath,
  }) {
    return Image(
      code: code ?? this.code,
      path: path ?? this.path,
      cachedPath: cachedPath ?? this.cachedPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'path': path,
      'cachedPath': cachedPath,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, path, cachedPath];
}
