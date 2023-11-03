import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdaper.dart';

class ProductListPage extends StatefulWidget {
  // 接收参数
  final Map arguments;

  const ProductListPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // GlobalKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 商品列表
  Widget _productListWidget() {
    return Container(
      padding: EdgeInsets.all(ScreenAdaper.width(10)),
      margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenAdaper.width(180),
                    height: ScreenAdaper.height(180),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/list2.jpg",
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenAdaper.height(180),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2019夏季新款气质高贵洋气阔太太有女人味中长款",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9)),
                                child: const Text('4g'),
                              ),
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9)),
                                child: const Text('126'),
                              )
                            ],
                          ),
                          Text(
                            "¥188",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750),
      child: Container(
        height: ScreenAdaper.height(80),
        width: ScreenAdaper.width(750),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: const Color(0xffe8e8e8),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // 打开抽屉
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.width(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: const Text(
                    "筛选",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("商品列表"),
        actions: [Text("")],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text("实现筛选功能"),
        ),
      ),
      body: Stack(
        children: [
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
