import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Config.dart';
import '../provider/CheckOut.dart';
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                            style: TextStyle(color: Colors.red)),
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

    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
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
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: Column(
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
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("总价:￥140", style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child:
                            Text('立即下单', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {},
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
