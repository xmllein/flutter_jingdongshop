import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/Config.dart';
import '../services/EventBus.dart';
import '../services/ScreenAdapter.dart';
import '../services/Storage.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //监听登录页面销毁的事件
  @override
  dispose() {
    super.dispose();
    // 广播登录成功事件
    eventBus.fire(UserEvent('登录成功...'));
  }

  String username = '';
  String password = '';

  doLogin() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(username)) {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码不正确',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio()
          .post(api, data: {"username": username, "password": password});
      if (response.data["success"]) {
        print(response.data);
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("登录页面"),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: ScreenAdapter.width(160),
                width: ScreenAdapter.width(160),
                // child: Image.asset('images/login.png'),
                child: Image.network(
                    'https://www.itying.com/images/flutter/list5.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            JdText(
              text: "请输入用户名",
              onChanged: (value) {
                username = value;
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerFirst');
                      },
                      child: Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "登录",
              color: Colors.red,
              height: 74,
              cb: doLogin,
            )
          ],
        ),
      ),
    );
  }
}
