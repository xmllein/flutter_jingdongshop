import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Cart.dart';
import '../../services/ScreenAdapter.dart';
import '../Cart/CartItem.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 是否编辑
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取购物车数据
    var cartProvider = Provider.of<Cart>(context);
    // cartProvider.init();
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
            child: const IconButton(
              icon: Icon(
                Icons.launch,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          )
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ListView(
                      children: cartProvider.cartList.map((value) {
                        return CartItem(value);
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(78),
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black12)),
                        color: Colors.white,
                      ),
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(78),
                      padding: const EdgeInsets.fromLTRB(0, 13, 10, 13),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: ScreenAdapter.width(60),
                                  child: Checkbox(
                                    value: cartProvider.isCheckedAll,
                                    activeColor: Colors.pink,
                                    onChanged: (val) {
                                      cartProvider.changeCheckAll(val!);
                                    },
                                  ),
                                ),
                                const Text("全选"),
                                const SizedBox(width: 20),
                                Text("合计："),
                                Text(
                                  "￥${cartProvider.allPrice}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _isEdit
                                ? ElevatedButton(
                                    child: const Text(
                                      "结算",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    child: const Text(
                                      "删除",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      cartProvider.removeItem();
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text("购物车为空"),
            ),
    );
  }
}
