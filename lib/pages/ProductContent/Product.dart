import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';

import '../../config/Config.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';

//广播
import '../../services/EventBus.dart';

class ProductPage extends StatefulWidget {
  final List _productContentList;

  const ProductPage(this._productContentList, {Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 详情页面数据
  late ProductItemModel _productContent;

  // 属性
  late List _attr = [];

  // 监听广播
  var actionEventBus;

  @override
  initState() {
    super.initState();
    _productContent = widget._productContentList[0];
    _attr = _productContent.attr;

    actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      _attrBottomSheet();
    });
  }

  //销毁
  @override
  void dispose() {
    super.dispose();
    actionEventBus.cancel(); //取消事件监听
  }

  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(10),
        child: Chip(
          label: Text("${item}"),
          padding: const EdgeInsets.all(10),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    for (var attrItem in _attr) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    }

    return attrList;
  }

  _attrBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (contex) {
        return GestureDetector(
          //解决showModalBottomSheet点击消失的问题
          onTap: () {
            return null;
          },
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getAttrWidget(),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 26,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(76),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: JdButton(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          cb: () {
                            print('加入购物车');
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: JdButton(
                            color: const Color.fromRGBO(255, 165, 0, 0.9),
                            text: "立即购买",
                            cb: () {
                              print('立即购买');
                            },
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 处理图片显示
    String pic = _productContent.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(pic, fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(_productContent.title,
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdapter.size(36))),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(_productContent.subTitle,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.size(28)))),
          //价格
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      const Text("特价: "),
                      Text("¥${_productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("原价: "),
                      Text("¥${_productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: ScreenAdapter.height(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: const Row(
                children: <Widget>[
                  Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115，黑色，XL，1件")
                ],
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: ScreenAdapter.height(80),
            child: const Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
