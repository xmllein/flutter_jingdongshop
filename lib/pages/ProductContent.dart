import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/ProductContent/Product.dart';
import 'package:flutter_jdshop/pages/ProductContent/ProductComment.dart';
import 'package:flutter_jdshop/pages/ProductContent/ProductDetail.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  const ProductContentPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
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
        body: Stack(
          children: [
            const TabBarView(children: [
              ProductPage(),
              ProductDetailPage(),
              ProductCommentPage(),
            ]),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.width(80),
              bottom: 20,
              child: Container(
                color: Colors.red,
                child: const Text("底部"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
