import 'package:flutter/material.dart';

class PriceProvider with ChangeNotifier {
  int newPrice = 0;

  int addItem({required int price}) {
    newPrice = newPrice + price;
    notifyListeners();
    return newPrice;
  }

  int removeItem({required int price}) {
    newPrice = newPrice - price;
    notifyListeners();
    return newPrice;
  }

  void clearPrice() {
    newPrice = 0;
    notifyListeners();
  }
}
