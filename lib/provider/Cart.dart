import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/Storage.dart';

class Cart with ChangeNotifier {
  List _cartList = []; //

  // 全选
  bool _isCheckedAll = false;

  bool get isCheckedAll => _isCheckedAll;

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

    // 判断是否全选
    _isCheckedAll = isCheckAll();

    notifyListeners();
  }

  // 更新数据
  updateCartList() {
    // 重新获取数据
    init();
  }

  // 改变数量，重新保存
  changeItemCount() {
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  // 全选， 反选
  changeCheckAll(bool flag) {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]["checked"] = flag;
    }
    _isCheckedAll = flag;
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  // 判断是否全选
  isCheckAll() {
    if (_cartList.isNotEmpty) {
      for (var i = 0; i < _cartList.length; i++) {
        if (_cartList[i]["checked"] == false) {
          _isCheckedAll = false;
          break;
        } else {
          _isCheckedAll = true;
        }
      }
    } else {
      _isCheckedAll = false;
    }
    notifyListeners();
  }

  // 监听单个checkbox 改变
  itemChageCheck() {
    if (isCheckAll()) {
      _isCheckedAll = true;
    } else {
      _isCheckedAll = false;
    }
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  // 删除单个
  removeItemById(id) {
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["_id"] == id) {
        _cartList.removeAt(i);
        break;
      }
    }
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  // 删除
  removeItem() {
    List tempList = [];
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"] == false) {
        tempList.add(_cartList[i]);
      }
    }
    _cartList = tempList;
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  // 改变checkbox 状态
  changeCheckState() {
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }
}
