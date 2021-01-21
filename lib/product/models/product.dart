import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:lastResearch/product/models/image.dart';

import 'variant.dart';

class Product extends Equatable {
  Product({
    this.code,
    this.name,
    this.slug,
    this.channelCode,
    this.description,
    this.shortDescription,
    this.variants,
    this.images,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    final list = <Variant>[];

    map['variants'].forEach(
        (k, v) => list.add(Variant.fromMap(v as Map<String, dynamic>)));

    return Product(
        code: map['code'] as String,
        name: map['name'] as String,
        slug: map['slug'] as String,
        channelCode: map['channelCode'] as String,
        description: map['description'] as String,
        shortDescription: map['shortDescription'] as String,
        variants: list,
        images: List<Image>.from((map['images'] as Iterable<dynamic>)
            ?.map((x) => Image.fromMap(x as Map<String, dynamic>))));
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  final String code;
  final String name;
  final String slug;
  final String channelCode;
  final String description;
  final String shortDescription;
  final List<Variant> variants;
  final List<Image> images;

  Product copyWith(
      {String code,
      String name,
      String slug,
      String channelCode,
      String description,
      String shortDescription,
      List<Variant> variants,
      List<Image> images}) {
    return Product(
      code: code ?? this.code,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      channelCode: channelCode ?? this.channelCode,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      variants: variants ?? this.variants,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'slug': slug,
      'channelCode': channelCode,
      'description': description,
      'shortDescription': shortDescription,
      'variants': variants,
      'images': images,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      code,
      name,
      slug,
      channelCode,
      description,
      shortDescription,
      variants,
      images
    ];
  }
}
