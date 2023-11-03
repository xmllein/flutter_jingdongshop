import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_jdshop/services/ScreenAdaper.dart';
import 'package:flutter_jdshop/widget/LoadingWidget.dart';

import '../config/Config.dart';

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

  // 用于上拉分页
  ScrollController _scrollController = ScrollController();

  // 分页
  int _page = 1;

  // 每页多少条数据
  int _pageSize = 8;

  // 列表数据
  List _productListData = [];

  // 排序
  String _sort = "";

  // 请求开关
  bool _flag = true;

  // 是否有数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    // 获取商品列表数据
    _getProductListData();

    // 监听滚动条滚动事件
    _scrollController.addListener(() {
      // 判断是否滚动到了底部
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 20 &&
          _flag == true &&
          _hasMore == true) {
        // print("滚动到了底部");
        setState(() {
          _page++;
        });
        // 获取商品列表数据
        _getProductListData();
      }
    });
  }

  // 获取商品列表数据
  _getProductListData() async {
    setState(() {
      _flag = false;
    });
    var api =
        "${Config.domain}api/plist?cid=${widget.arguments['cid']}&page=$_page&pageSize=$_pageSize&sort=$_sort";
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);

    // 是否有下一页
    if (productList.result.length < _pageSize) {
      setState(() {
        _productListData.addAll(productList.result);
        _hasMore = false;
      });
    } else {
      setState(() {
        _productListData.addAll(productList.result);
        _flag = true;
      });
    }
  }

  // 请求更多
  Widget _showMoreWidget(index) {
    if (_hasMore) {
      return (index == _productListData.length - 1)
          ? const LoadingWidget()
          : const Text("");
    } else {
      return (index == _productListData.length - 1)
          ? const Text("--我是有底线的--")
          : const Text("");
    }
  }

  // 商品列表
  Widget _productListWidget() {
    if (_productListData.isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(ScreenAdaper.width(10)),
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            // 图片转换格式
            String pic = _productListData[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network(pic, fit: BoxFit.cover),
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
                              "${_productListData[index].title}",
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
                              "¥${_productListData[index].price}",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                // 加载更多
                _showMoreWidget(index),
              ],
            );
          },
          itemCount: _productListData.length,
        ),
      );
    } else {
      return const LoadingWidget();
    }
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
