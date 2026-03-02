import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/Product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}


