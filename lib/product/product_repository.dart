import 'dart:async';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'models/models.dart';

class ProductRepository {
  Future<List<Product>> findByName(String name) async {
    final response = await http.get(
        'https://altasell.codebuds.com/shop-api/products/by-search-query/$name');

    if (response.statusCode != 200) {
      throw Exception('Error fetching products');
    }

    final productJson = convert.jsonDecode(response.body);
    final childrens = productJson['items'] as List;
    final jsonChildrens = <Product>[];

    for (var i = 0; i < childrens.length; i++) {
      final encodedJson = convert.jsonEncode(childrens[i]);
      jsonChildrens.add(Product.fromJson(encodedJson));
    }

    return jsonChildrens;
  }
}
