import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Counter.dart';
import '../../services/ScreenAdapter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          height: ScreenAdapter.height(220),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ClipOval(
                  child: Image.asset(
                    'images/user.png',
                    fit: BoxFit.cover,
                    width: ScreenAdapter.width(100),
                    height: ScreenAdapter.width(100),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("登录/注册", style: TextStyle(color: Colors.white)),
                ),
              )

              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text("用户名：124124125",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: ScreenAdapter.size(32))),
              //       Text("普通会员",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: ScreenAdapter.size(24))),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.red),
          title: Text("全部订单"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment, color: Colors.green),
          title: Text("待付款"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_car_wash, color: Colors.orange),
          title: Text("待收货"),
        ),
        Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9)),
        ListTile(
          leading: Icon(Icons.favorite, color: Colors.lightGreen),
          title: Text("我的收藏"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people, color: Colors.black54),
          title: Text("在线客服"),
        ),
        Divider(),
      ],
    ));
  }
}
