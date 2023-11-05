import 'package:flutter/material.dart';

import '../../services/ScreenAdapter.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("收货地址列表"),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.red),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("张三  15201681234"),
                          SizedBox(height: 10),
                          Text("北京市海淀区西二旗"),
                        ]),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: 20),
                  ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("张三  15201xxxx234"),
                          SizedBox(height: 10),
                          Text("北京市海defdsafaf西二旗"),
                        ]),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: 20),
                  ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("张三  15201xxxx234"),
                          SizedBox(height: 10),
                          Text("北京市海defdsafaf西二旗"),
                        ]),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: 20),
                  ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("张三  15201xxxx234"),
                          SizedBox(height: 10),
                          Text("北京市海defdsafaf西二旗"),
                        ]),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: 20),
                  ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("张三  15201xxxx234"),
                          SizedBox(height: 10),
                          Text("北京市海defdsafaf西二旗"),
                        ]),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(88),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black26))),
                  child: InkWell(
                    child: Row(
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
