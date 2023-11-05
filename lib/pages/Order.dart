import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/OrderModel.dart';

import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import '../services/SignServices.dart';
import '../services/UserServices.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List _orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListData();
  }

  // 获取订单列表数据
  void _getListData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/orderList?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);
    setState(() {
      var orderMode = OrderModel.fromJson(response.data);
      _orderList = orderMode.result;
    });
  }

  //自定义商品列表组件
  List<Widget> _orderItemWidget(orderItems) {
    List<Widget> tempList = [];
    for (var i = 0; i < orderItems.length; i++) {
      // 图片转换格式
      String pic = orderItems[i].productImg;
      pic = Config.domain + pic.replaceAll('\\', '/');
      tempList.add(Column(
        children: <Widget>[
          const SizedBox(height: 10),
          ListTile(
            leading: SizedBox(
              width: ScreenAdapter.width(120),
              height: ScreenAdapter.height(120),
              child: Image.network(
                pic,
                fit: BoxFit.cover,
              ),
            ),
            title: Text("${orderItems[i].productTitle}"),
            trailing: Text('x${orderItems[i].productCount}'),
          ),
          const SizedBox(height: 10)
        ],
      ));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的订单"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(80), 0, 0),
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
                children: _orderList.map((value) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/orderinfo');
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("订单编号：${value.id}",
                            style: const TextStyle(color: Colors.black54)),
                      ),
                      const Divider(),
                      Column(
                        children: _orderItemWidget(value.orderItem),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Text("合计：￥${value.allPrice}"),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: const Text("申请售后"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
          ),
          Positioned(
            top: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(76),
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(76),
              color: Colors.white,
              child: const Row(
                children: <Widget>[
                  Expanded(
                    child: Text("全部", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待付款", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待收货", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已完成", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已取消", textAlign: TextAlign.center),
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
