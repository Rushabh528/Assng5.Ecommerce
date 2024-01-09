import 'package:flutter/material.dart';

class Provider1 extends ChangeNotifier {
  List item = [];
  List get items => item;

  List price = [];
  List get prices => price;

  void add1(String name) {
    if (items.contains(name)) {
      items.remove(name);
    } else {
      items.add(name);
    }
    notifyListeners();
  }

  int total = 0;
  void addprice(int price) {
    if (prices.contains(price)) {
      prices.remove(price);
    } else {
      prices.add(price);
    }

    notifyListeners();
  }

  void sum(int price) {
    if (prices.contains(price)) {
      total = total + price;
    } else {
      total -= price;
    }

    notifyListeners();
  }

  void nfy() {
    notifyListeners();
  }

  void t0() {
    total = 0;
    notifyListeners();
  }
}
