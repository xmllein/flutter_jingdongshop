import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/Cart.dart';
import '../../provider/CheckOut.dart';
import '../../services/CartServices.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/UserServices.dart';
import '../Cart/CartItem.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 是否编辑
  bool _isEdit = true;

  var checkOutProvider;

  //去结算
  doCheckOut() async {
    //1、获取购物车选中的数据
    List checkOutData = await CartServices.getCheckOutData();
    //2、保存购物车选中的数据
    checkOutProvider.changeCheckOutListData(checkOutData);
    //3、购物车有没有选中的数据
    if (checkOutData.length > 0) {
      //4、判断用户有没有登录
      var loginState = await UserServices.getUserLoginState();
      if (loginState) {
        Navigator.pushNamed(context, '/checkOut');
      } else {
        Fluttertoast.showToast(
          msg: '您还没有登录，请登录以后再去结算',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
      }
    } else {
      Fluttertoast.showToast(
        msg: '购物车没有选中的数据',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取购物车数据
    var cartProvider = Provider.of<Cart>(context);
    // 结算数据
    checkOutProvider = Provider.of<CheckOut>(context);
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
                    height: ScreenAdapter.height(100),
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black12)),
                        color: Colors.white,
                      ),
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(100),
                      padding: const EdgeInsets.all(5),
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
                                const Text(
                                  "全选",
                                ),
                                const SizedBox(width: 20),
                                const Text(
                                  "合计：",
                                ),
                                Text(
                                  "￥${cartProvider.allPrice}",
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.size(36),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _isEdit
                                ? ElevatedButton(
                                    onPressed: doCheckOut,
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 40),
                                    ),
                                    child: const Text(
                                      "结算",
                                      style: TextStyle(
                                          // fontSize: ScreenAdapter.size(20),
                                          color: Colors.white),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      fixedSize: Size(100, 40),
                                    ),
                                    child: const Text(
                                      "删除",
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontSize: ScreenAdapter.size(20),
                                      ),
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
