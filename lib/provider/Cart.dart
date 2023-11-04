import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = []; //状态
  // int _cartNum=0;

  int get cartNum => _cartList.length;
  List get cartList => _cartList;

  addData(value) {
    _cartList.add(value);
    notifyListeners();
  }

  deleteData(value) {
    _cartList.remove(value);
    notifyListeners();
  }
}
