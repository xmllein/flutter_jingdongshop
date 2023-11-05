import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/Storage.dart';

class Cart with ChangeNotifier {
  List _cartList = []; // 状态

  List get cartList => _cartList; // 获取状态

  Cart() {
    init();
  }

  // 初始化
  init() async {
    // Storage.remove('cartList');
    // 获取本地存储的数据
    try {
      List cartListData =
          json.decode(await Storage.getString('cartList') as String);
      _cartList = cartListData;
    } catch (e) {
      _cartList = [];
    }
    notifyListeners();
  }

  // 更新数据
  updateCartList() {
    // 重新获取数据
    init();
  }
}
