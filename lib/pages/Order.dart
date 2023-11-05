import 'package:flutter/material.dart';

import '../services/ScreenAdapter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(80), 0, 0),
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("订单编号：xxxxxxxx"),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教"),
                        trailing: Text('x1'),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教t入门实战视"),
                        trailing: Text('x1'),
                        onTap: () {
                          Navigator.pushNamed(context, '/orderinfo');
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Text("合计：￥345"),
                        trailing: ElevatedButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("订单编号：xxxxxxxx"),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教"),
                        trailing: Text('x1'),
                        onTap: () {
                          Navigator.pushNamed(context, '/orderinfo');
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教t入门实战视"),
                        trailing: Text('x1'),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Text("合计：￥345"),
                        trailing: ElevatedButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("订单编号：xxxxxxxx"),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教"),
                        trailing: Text('x1'),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(120),
                          height: ScreenAdapter.height(120),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("6小时学会TypeScript入门实战视频教t入门实战视"),
                        trailing: Text('x1'),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Text("合计：￥345"),
                        trailing: ElevatedButton(
                            child: Text("申请售后"),
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.black),
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(76),
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(76),
              color: Colors.white,
              child: Row(
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
