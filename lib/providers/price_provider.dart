import 'package:flutter/material.dart';

class PriceProvider with ChangeNotifier {
  int newPrice = 0;
  List<int> prices = [];

  int addItem({required int price}) {
    prices.add(price);
    newPrice = newPrice + price;
    notifyListeners();
    return newPrice;
  }

  int removeItem({required int price}) {
    newPrice = newPrice - price;
    notifyListeners();
    return newPrice;
  }

  int backButtonClicked() {
    newPrice = newPrice - prices.last;
    notifyListeners();
    return newPrice;
  }

  void clearPrice() {
    newPrice = 0;
    notifyListeners();
  }
}
