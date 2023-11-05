import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/ProductContent.dart';
import 'package:flutter_jdshop/pages/ProductList.dart';
import 'package:flutter_jdshop/pages/tabs/Cart.dart';
import '../pages/Address/AddressAdd.dart';
import '../pages/Address/AddressEdit.dart';
import '../pages/Address/AddressList.dart';
import '../pages/CheckOut.dart';
import '../pages/Login.dart';
import '../pages/Pay.dart';
import '../pages/RegisterFirst.dart';
import '../pages/RegisterSecond.dart';
import '../pages/RegisterThird.dart';
import '../pages/tabs/Tabs.dart';

// 引入Search 页面
import '../pages/Search.dart';
// 商品列表页面

// 配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/cart': (context) => const CartPage(),
  '/login': (context) => const LoginPage(),
  '/registerFirst': (context) => const RegisterFirstPage(),
  '/registerSecond': (context, {arguments}) =>
      RegisterSecondPage(arguments: arguments),
  '/registerThird': (context, {arguments}) =>
      RegisterThirdPage(arguments: arguments),
  '/productList': (context, {arguments}) =>
      ProductListPage(arguments: arguments),
  '/productContent': (context, {arguments}) =>
      ProductContentPage(arguments: arguments),
  '/checkOut': (context) => const CheckOutPage(),
  '/addressAdd': (context) => const AddressAddPage(),
  '/addressEdit': (context) => const AddressEditPage(),
  '/addressList': (context) => const AddressListPage(),
  '/pay': (context) => const PayPage(),
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
    return route;
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
