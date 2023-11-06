import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/Config.dart';
import '../../services/EventBus.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/SignServices.dart';
import '../../services/UserServices.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressList();

    //监听增加收货地址的广播
    eventBus.on<AddressEvent>().listen((event) {
      print(event.str);
      _getAddressList();
    });
  }

  //监听页面销毁的事件
  @override
  dispose() {
    super.dispose();
    eventBus.fire(CheckOutEvent('改收货地址成功...'));
  }

  // 获取收货地址列表
  _getAddressList() async {
    //请求接口
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);
    setState(() {
      addressList = response.data["result"];
    });
  }

  //修改默认收货地址
  _changeDefaultAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };
    var sign = SignServices.getSign(tempJson);
    var api = '${Config.domain}api/changeDefaultAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    Navigator.pop(context);
  }

  //删除收货地址
  _delAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "id": id,
      "salt": userinfo[0]["salt"]
    };
    var sign = SignServices.getSign(tempJson);

    var api = '${Config.domain}api/deleteAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]["_id"], "id": id, "sign": sign});
    _getAddressList(); //删除收货地址完成后重新获取列表
  }

  //弹出框
  _showDelAlertDialog(id) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示信息!"),
            content: const Text("您确定要删除吗?"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text("确定"),
                onPressed: () async {
                  //执行删除操作
                  _delAddress(id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("收货地址列表"),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  if (addressList[index]["default_address"] == 1) {
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        ListTile(
                          leading: const Icon(Icons.check, color: Colors.red),
                          title: InkWell(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                  const SizedBox(height: 10),
                                  Text("${addressList[index]["address"]}"),
                                ]),
                            onTap: () {
                              _changeDefaultAddress(addressList[index]["_id"]);
                            },
                            onLongPress: () {
                              _showDelAlertDialog(addressList[index]["_id"]);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.pushNamed(context, '/addressEdit',
                                  arguments: {
                                    "id": addressList[index]["_id"],
                                    "name": addressList[index]["name"],
                                    "phone": addressList[index]["phone"],
                                    "address": addressList[index]["address"],
                                  });
                            },
                          ),
                        ),
                        const Divider(height: 20),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        ListTile(
                          title: InkWell(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                  const SizedBox(height: 10),
                                  Text("${addressList[index]["address"]}"),
                                ]),
                            onTap: () {
                              _changeDefaultAddress(addressList[index]["_id"]);
                            },
                            onLongPress: () {
                              _showDelAlertDialog(addressList[index]["_id"]);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.pushNamed(context, '/addressEdit',
                                  arguments: {
                                    "id": addressList[index]["_id"],
                                    "name": addressList[index]["name"],
                                    "phone": addressList[index]["phone"],
                                    "address": addressList[index]["address"],
                                  });
                            },
                          ),
                        ),
                        const Divider(height: 20),
                      ],
                    );
                  }
                },
              ),
              Positioned(
                bottom: 0,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(88),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black26))),
                  child: InkWell(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white),
                        Text("增加收货地址", style: TextStyle(color: Colors.white))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
