import 'package:flutter/material.dart';
import 'Home.dart';
import 'Category.dart';
import 'Cart.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  //页面
  final List<Widget> _pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const UserPage(),
  ];

  // 标题
  final List<String> _titleList = [
    '京东首页',
    '商品分类',
    '购物车',
    '用户中心',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleList[_currentIndex]),
      ),
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
