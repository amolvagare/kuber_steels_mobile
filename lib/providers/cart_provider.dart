import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, List<CartItem>> _customerCarts = {};
  String? _currentCustomerId;
  
  String? get currentCustomerId => _currentCustomerId;
  
  void setCustomer(String customerId) {
    _currentCustomerId = customerId;
    _customerCarts[customerId] ??= [];
    notifyListeners();
  }
  
  List<CartItem> get items {
    if (_currentCustomerId == null) return [];
    return List.unmodifiable(_customerCarts[_currentCustomerId] ?? []);
  }
  
  int get itemCount {
    if (_currentCustomerId == null) return 0;
    return _customerCarts[_currentCustomerId]?.length ?? 0;
  }
  
  void addItem(CartItem item) {
    if (_currentCustomerId == null) return;
    _customerCarts[_currentCustomerId]?.add(item);
    notifyListeners();
  }
  
  void removeItem(int index) {
    if (_currentCustomerId == null) return;
    _customerCarts[_currentCustomerId]?.removeAt(index);
    notifyListeners();
  }
  
  void clearCart() {
    if (_currentCustomerId == null) return;
    _customerCarts[_currentCustomerId]?.clear();
    notifyListeners();
  }
  
  void clearCustomer() {
    _currentCustomerId = null;
    notifyListeners();
  }
} 