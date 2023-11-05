import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/Cart/CartNum.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';

import '../../config/Config.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  final Map _itemData;

  const CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // 购物车数据
  late Map _itemData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    //处理图片
    String pic = _itemData["pic"];
    pic = Config.domain + pic.replaceAll('\\', '/');

    var cartProvider = Provider.of<Cart>(context);

    return Container(
      height: ScreenAdapter.height(200),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: _itemData["checked"],
              onChanged: (val) {
                setState(() {
                  _itemData["checked"] = val;
                });

                cartProvider.itemChageCheck();
              },
              activeColor: Colors.pink,
            ),
          ),
          SizedBox(
            width: ScreenAdapter.width(160),
            child: Image.network(pic, fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${_itemData["title"]}", maxLines: 2),
                  Text("${_itemData["selectedAttr"]}", maxLines: 1),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${_itemData["price"]}",
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
