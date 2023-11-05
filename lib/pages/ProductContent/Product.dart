import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/ProductContentModel.dart';
import '../../pages/ProductContent/CartNum.dart';

import '../../config/Config.dart';
import '../../provider/Cart.dart';
import '../../services/CartServices.dart';
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

  // 选中的值
  late String _selectedValue;

  // 属性
  late List _attr = [];

  // 监听广播
  var actionEventBus;

  var _cartProvider;

  @override
  initState() {
    super.initState();
    // 详情页面数据
    _productContent = widget._productContentList[0];
    // 属性赋值
    _attr = _productContent.attr;

    // 初始化Attr 格式化数据
    _initAttr();

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

  //初始化Attr 格式化数据
  _initAttr() {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }

    _getSelectedAttrValue();
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      _attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var list = _attr;
    List tempArr = [];
    for (var i = 0; i < list.length; i++) {
      for (var j = 0; j < list[i].attrList.length; j++) {
        if (list[i].attrList[j]['checked'] == true) {
          tempArr.add(list[i].attrList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      _selectedValue = tempArr.join(',');
      //给筛选属性赋值
      _productContent.selectedAttr = _selectedValue;
    });
  }

//循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAttr(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text("${item["title"]}",
                style: TextStyle(
                    color: item["checked"] ? Colors.white : Colors.black54)),
            padding: const EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    for (var attrItem in _attr) {
      attrList.add(Wrap(
        children: <Widget>[
          SizedBox(
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
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    }

    return attrList;
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setBottomState) {
            return GestureDetector(
              //解决showModalBottomSheet点击消失的问题
              onTap: () {
                return;
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    child: ListView(
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _getAttrWidget(setBottomState)),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: ScreenAdapter.height(80),
                          child: Row(
                            children: <Widget>[
                              const Text("数量: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              CartNum(_productContent)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(76),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: JdButton(
                              color: const Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                await CartServices.addCart(_productContent);
                                //关闭底部筛选属性
                                Navigator.of(context).pop();
                                _cartProvider.updateCartList();

                                Fluttertoast.showToast(
                                    msg: "加入购物车成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _cartProvider = Provider.of<Cart>(context);
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
