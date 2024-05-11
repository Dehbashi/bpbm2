import 'package:flutter/material.dart';

class PriceProvider with ChangeNotifier {
  double newPrice = 0;
  List<double> prices = [];

  double addItem({required double price}) {
    prices.add(price);
    newPrice = newPrice + price;
    notifyListeners();
    return newPrice;
  }

  double removeItem({required double price}) {
    newPrice = newPrice - price;
    notifyListeners();
    return newPrice;
  }

  double backButtonClicked() {
    newPrice = newPrice - prices.last;
    notifyListeners();
    return newPrice;
  }

  void clearPrice() {
    newPrice = 0;
    notifyListeners();
  }
}
