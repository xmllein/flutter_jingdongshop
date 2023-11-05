import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({super.key});

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = "";

  sendCode() async {
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": tel});
      if (response.data["success"]) {
        print(response); //演示期间服务器直接返回  给手机发送的验证码

        Navigator.pushNamed(context, '/registerSecond',
            arguments: {"tel": tel});
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            JdText(
              text: "请输入手机号",
              onChanged: (value) {
                tel = value;
              },
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: sendCode,
            )
          ],
        ),
      ),
    );
  }
}
