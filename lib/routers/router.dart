import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
// 引入Search 页面
import '../pages/Search.dart';

// 配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
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
