import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';

import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../widget/JdText.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({super.key});

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';

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
              ),
              SizedBox(height: 10),
              JdText(
                text: "收货人电话",
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
              ),
              SizedBox(height: 10),
              SizedBox(height: 40),
              JdButton(
                text: "增加",
                color: Colors.red,
                cb: () {},
              )
            ],
          ),
        ));
  }
}
