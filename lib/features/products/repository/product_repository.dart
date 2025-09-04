import 'dart:convert';
import 'package:http/http.dart' as http; // as for http to avoid conflict with other packages

import '../models/product_model.dart';

class ProductRemoteRepository {
  static const baseUrl = 'https://dummyjson.com';

  Future<List<ProductModel>> fetchAllProducts({int limit = 30, int skip = 0}) async {
    final uri = Uri.parse('$baseUrl/products?limit=$limit&skip=$skip');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final list = (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return list;
    }
    throw Exception('Failed to load products');
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final uri = Uri.parse('$baseUrl/products/search?q=$query');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final list = (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return list;
    }
    throw Exception('Search failed');
  }

  Future<List<String>> fetchCategories() async {
    final uri = Uri.parse('$baseUrl/products/categories');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).cast<String>();
    }
    throw Exception('Failed to load categories');
  }
}
