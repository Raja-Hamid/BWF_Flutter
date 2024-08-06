import 'package:flutter/material.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  double totalPrice() {
    return _items.fold(0.0, (total, current) => total + current.price);
  }
}
