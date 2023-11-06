import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../config/Config.dart';
import '../provider/Cart.dart';
import '../provider/CheckOut.dart';
import '../services/CheckOutServices.dart';
import '../services/EventBus.dart';
import '../services/ScreenAdapter.dart';
import '../services/SignServices.dart';
import '../services/UserServices.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List _addressList = [];

  @override
  initState() {
    super.initState();
    _getDefaultAddress();

    //监听广播
    eventBus.on<CheckOutEvent>().listen((event) {
      print(event.str);
      _getDefaultAddress();
    });
  }

  // 获取默认收货地址
  _getDefaultAddress() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]["_id"], "salt": userinfo[0]["salt"]};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/oneAddressList?uid=${userinfo[0]["_id"]}&sign=${sign}';
    var response = await Dio().get(api);
    print(response);
    setState(() {
      _addressList = response.data['result'];
    });
  }

  Widget _checkOutItem(item) {
    // 图片转换格式
    String pic = item["pic"];
    pic = Config.domain + pic.replaceAll('\\', '/');
    return Row(
      children: <Widget>[
        Container(
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
                  Text("${item["title"]}", maxLines: 2),
                  Text("${item["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${item["price"]}",
                            style: const TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item["count"]}"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var checkOutProvider = Provider.of<CheckOut>(context);

    var cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("结算"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      _addressList.isNotEmpty
                          ? ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${_addressList[0]["name"]}  ${_addressList[0]["phone"]}"),
                                  const SizedBox(height: 10),
                                  Text("${_addressList[0]["address"]}"),
                                ],
                              ),
                              trailing: const Icon(Icons.navigate_next),
                              onTap: () {
                                Navigator.pushNamed(context, '/addressList');
                              },
                            )
                          : ListTile(
                              leading: const Icon(Icons.add_location),
                              title: const Center(
                                child: Text("请添加收货地址"),
                              ),
                              trailing: const Icon(Icons.navigate_next),
                              onTap: () {
                                Navigator.pushNamed(context, '/addressAdd');
                              },
                            ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: Column(
                      children: checkOutProvider.checkOutListData.map((value) {
                    return Column(
                      children: <Widget>[_checkOutItem(value), Divider()],
                    );
                  }).toList()),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("商品总金额:￥100"),
                      Divider(),
                      Text("立减:￥5"),
                      Divider(),
                      Text("运费:￥0"),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              child: Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: Stack(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("总价:￥140", style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () async {
                          if (_addressList.isNotEmpty) {
                            List userinfo = await UserServices.getUserInfo();
                            //注意：商品总价保留一位小数
                            var allPrice = CheckOutServices.getAllPrice(
                                    checkOutProvider.checkOutListData)
                                .toStringAsFixed(1);

                            //获取签名
                            var sign = SignServices.getSign({
                              "uid": userinfo[0]["_id"],
                              "phone": _addressList[0]["phone"],
                              "address": _addressList[0]["address"],
                              "name": _addressList[0]["name"],
                              "all_price": allPrice,
                              "products": json
                                  .encode(checkOutProvider.checkOutListData),
                              "salt": userinfo[0]["salt"] //私钥
                            });
                            //请求接口
                            var api = '${Config.domain}api/doOrder';
                            var response = await Dio().post(api, data: {
                              "uid": userinfo[0]["_id"],
                              "phone": _addressList[0]["phone"],
                              "address": _addressList[0]["address"],
                              "name": _addressList[0]["name"],
                              "all_price": allPrice,
                              "products": json
                                  .encode(checkOutProvider.checkOutListData),
                              "sign": sign
                            });
                            print(response);
                            if (response.data["success"]) {
                              //删除购物车选中的商品数据
                              await CheckOutServices.removeUnSelectedCartItem();

                              //调用CartProvider更新购物车数据
                              cartProvider.updateCartList();

                              //跳转到支付页面
                              Navigator.pushNamed(context, '/pay');
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: '请填写收货地址',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        },
                        child: const Text('立即下单',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
