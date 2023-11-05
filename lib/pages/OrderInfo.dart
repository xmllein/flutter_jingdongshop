import 'package:flutter/material.dart';

import '../services/ScreenAdapter.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({super.key});

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("订单详情")),
      body: ListView(
        children: <Widget>[
          //收货地址
          Container(
            color: Colors.white,
            child: const Column(
              children: <Widget>[
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("张三  15201686455"),
                      SizedBox(height: 10),
                      Text("北京市海淀区 西二旗"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //列表
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: ScreenAdapter.width(120),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list2.jpg",
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              Text("水龙头 洗衣机",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              ListTile(
                                leading: Text("￥100",
                                    style: TextStyle(color: Colors.red)),
                                trailing: Text("x2"),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: ScreenAdapter.width(120),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list2.jpg",
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              Text("水龙头 洗衣机",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              ListTile(
                                leading: Text("￥100",
                                    style: TextStyle(color: Colors.red)),
                                trailing: Text("x2"),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),

          //详情信息
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: const Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("订单编号:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("124215215xx324")
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("下单日期:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("2019-12-09")
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("支付方式:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("微信支付")
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("配送方式:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("顺丰")
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: const Column(
              children: <Widget>[
                ListTile(
                    title: Row(
                  children: <Widget>[
                    Text("总金额:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("￥414元", style: TextStyle(color: Colors.red))
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
