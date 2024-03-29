import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';

import '../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  final Map _itemData;

  const CartNum(this._itemData, {Key? key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map _itemData = {};

  var cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<Cart>(context);

    return Container(
      width: ScreenAdapter.width(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (_itemData["count"] > 1) {
          setState(() {
            _itemData["count"]--;
          });
          cartProvider.changeItemCount();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: const Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          _itemData["count"]++;
        });
        // 调用Provider更新数据
        cartProvider.changeItemCount();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: const Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      decoration: const BoxDecoration(
          border: Border(
        left: BorderSide(width: 1, color: Colors.black12),
        right: BorderSide(width: 1, color: Colors.black12),
      )),
      height: ScreenAdapter.height(45),
      child: Text("${_itemData["count"]}"),
    );
  }
}
