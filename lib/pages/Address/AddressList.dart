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

  _getAddressList() async {
    //请求接口
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};

    var sign = SignServices.getSign(tempJson);

    var api =
        '${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}';

    var response = await Dio().get(api);
    // print(response.data["result"]);

    setState(() {
      addressList = response.data["result"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("收货地址列表"),
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
                          leading: Icon(Icons.check, color: Colors.red),
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                const SizedBox(height: 10),
                                Text("${addressList[index]["address"]}"),
                              ]),
                          trailing: Icon(Icons.edit, color: Colors.blue),
                        ),
                        const Divider(height: 20),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        ListTile(
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                const SizedBox(height: 10),
                                Text("${addressList[index]["address"]}"),
                              ]),
                          trailing: const Icon(Icons.edit, color: Colors.blue),
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