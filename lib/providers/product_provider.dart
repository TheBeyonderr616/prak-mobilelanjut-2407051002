import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  ProductState _state = ProductState.initial;
  List<Product> _products = [];
  String _errorMessage = '';

  ProductState get state => _state;
  List<Product> get products => _products;
  String get errorMessage => _errorMessage;
  bool get isLoading => _state == ProductState.loading;

  Future<void> fetchProducts() async {
    _state = ProductState.loading;
    _errorMessage = '';
    notifyListeners(); 

    try {
      _products = await _productService.getProducts();
      _state = ProductState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProductState.error;
    }

    notifyListeners(); 
  }
}