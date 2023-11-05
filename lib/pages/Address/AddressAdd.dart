import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/Config.dart';
import '../../services/EventBus.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/SignServices.dart';
import '../../services/UserServices.dart';
import '../../widget/JdButton.dart';
import '../../widget/JdText.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({super.key});

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';

  // 用户名
  String name = '';

  // 电话
  String phone = '';

  // 详细地址
  String address = '';

  //监听页面销毁的事件
  @override
  dispose() {
    super.dispose();
    eventBus.fire(AddressEvent('增加成功...'));
    eventBus.fire(CheckOutEvent('改收货地址成功...'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("增加收货地址"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              JdText(
                text: "收货人姓名",
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 10),
              JdText(
                text: "收货人电话",
                onChanged: (value) {
                  phone = value;
                },
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 5),
                height: ScreenAdapter.height(68),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_location),
                      this.area.length > 0
                          ? Text('${this.area}',
                              style: TextStyle(color: Colors.black54))
                          : Text('省/市/区',
                              style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  onTap: () async {
                    Result? result = await CityPickers.showCityPicker(
                      context: context,
                      cancelWidget:
                          Text("取消", style: TextStyle(color: Colors.blue)),
                      confirmWidget: Text(
                        "确定",
                        style: TextStyle(color: Colors.blue),
                      ),
                    );

                    // print(result);
                    setState(() {
                      this.area =
                          "${result?.provinceName}/${result?.cityName}/${result?.areaName}";
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              JdText(
                text: "详细地址",
                maxLines: 4,
                height: 200,
                onChanged: (value) {
                  address = "$area $value";
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 40),
              JdButton(
                text: "增加",
                color: Colors.red,
                cb: () async {
                  List userinfo = await UserServices.getUserInfo();

                  print(userinfo);

                  // print('1234');
                  var tempJson = {
                    "uid": userinfo[0]["_id"],
                    "name": this.name,
                    "phone": this.phone,
                    "address": this.address,
                    "salt": userinfo[0]["salt"]
                  };

                  var sign = SignServices.getSign(tempJson);
                  // print(sign);

                  var api = '${Config.domain}api/addAddress';
                  var result = await Dio().post(api, data: {
                    "uid": userinfo[0]["_id"],
                    "name": name,
                    "phone": phone,
                    "address": address,
                    "sign": sign
                  });

                  // if(result.data["success"]){

                  // }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}
