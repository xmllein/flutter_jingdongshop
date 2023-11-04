import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';
import 'package:flutter_jdshop/pages/ProductContent/Product.dart';
import 'package:flutter_jdshop/pages/ProductContent/ProductComment.dart';
import 'package:flutter_jdshop/pages/ProductContent/ProductDetail.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:flutter_jdshop/widget/LoadingWidget.dart';

import '../widget/JdButton.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  const ProductContentPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  // 详情页面数据
  final List _productContentList = [];

  // 请求数据
  _getProductContent() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments["id"]}';
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);

    setState(() {
      _productContentList.add(productContent.result);
    });
  }

  initState() {
    super.initState();
    _getProductContent();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ScreenAdapter.width(400),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      child: Text("商品"),
                    ),
                    Tab(
                      child: Text("详情"),
                    ),
                    Tab(
                      child: Text("评价"),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(600), 76, 10, 0),
                    items: [
                      PopupMenuItem(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Row(
                          children: <Widget>[Icon(Icons.home), Text("首页")],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        child: const Row(
                          children: <Widget>[Icon(Icons.search), Text("搜索")],
                        ),
                      )
                    ]);
              },
            )
          ],
        ),
        body: _productContentList.isNotEmpty
            ? Stack(
                children: [
                  TabBarView(children: [
                    // 消除警告
                    ProductPage(_productContentList),
                    ProductDetailPage(),
                    ProductCommentPage(),
                  ]),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.width(92),
                    bottom: 26,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black26, width: 1)),
                          color: Colors.white),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(top: ScreenAdapter.height(10)),
                            width: 100,
                            height: ScreenAdapter.height(88),
                            child: const Column(
                              children: <Widget>[
                                Icon(Icons.shopping_cart),
                                Text("购物车")
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () {
                                print('加入购物车');
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(255, 165, 0, 0.9),
                              text: "立即购买",
                              cb: () {
                                print('立即购买');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
