import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _displayedProducts = [];
  int _currentIndex = 0;
  final int batchSize = 6;
  bool isLoading = true;
  String? errorMessage;

  List<Product> get allProducts => _allProducts;
  List<Product> get displayedProducts => _displayedProducts;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _allProducts = await ApiService.fetchProducts();
      _currentIndex = 0;
      _displayedProducts = _allProducts.take(batchSize).toList();
    } catch (error) {
      errorMessage = "Failed to load products. Please try again.";
    }

    isLoading = false;
    notifyListeners();
  }

  void retryFetchProducts() {
    fetchProducts();
  }

  void loadNextBatch() {
    if (_allProducts.isEmpty) return;
    isLoading = true;
    notifyListeners();

    _currentIndex = (_currentIndex + batchSize) % _allProducts.length;
    _displayedProducts =
        _allProducts.skip(_currentIndex).take(batchSize).toList();

    isLoading = false;
    notifyListeners();
  }
}
