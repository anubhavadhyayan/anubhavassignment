import 'dart:convert';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com/products";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(baseUrl);
      print(data);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
