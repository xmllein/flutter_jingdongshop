import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
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
  var _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  //页面
  final List<Widget> _pageList = [
    // 首页
    const HomePage(),
    // 分类
    const CategoryPage(),
    // 购物车
    const CartPage(),
    // 个人中心
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
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: InkWell(
            onTap: () {
              // 跳转到搜索
              Navigator.pushNamed(context, '/search');
            },
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: ScreenAdapter.height(56),
                    decoration: BoxDecoration(
                      // color: const Color.fromRGBO(233, 233, 233, 0.8),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.black87,
                        ),
                        Text(
                          '笔记本',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.center_focus_weak,
            size: 28,
          ),
          onPressed: () {
            print('扫一扫');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              size: 28,
            ),
            onPressed: () {
              print('消息');
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // 不滑动
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
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
