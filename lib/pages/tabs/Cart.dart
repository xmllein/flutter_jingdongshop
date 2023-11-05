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
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取购物车数据
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: const <Widget>[
          IconButton(
            icon: Icon(
              Icons.launch,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? Stack(
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
                                  value: true,
                                  activeColor: Colors.pink,
                                  onChanged: (val) {},
                                ),
                              ),
                              const Text("全选")
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: const Text(
                              "结算",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("购物车为空"),
            ),
    );
  }
}
