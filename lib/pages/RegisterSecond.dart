import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';

class RegisterSecondPage extends StatefulWidget {
  final Map arguments;

  const RegisterSecondPage({super.key, required this.arguments});

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  late String tel;
  bool sendCodeBtn = false;
  int seconds = 10;
  late String code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tel = widget.arguments["tel"];
    _showTimer();
  }

  //重新发送验证码
  sendCode() async {
    setState(() {
      sendCodeBtn = false;
      seconds = 10;
      _showTimer();
    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": tel});
    if (response.data["success"]) {
      print(response); //演示期间服务器直接返回  给手机发送的验证码
    }
  }

  //倒计时
  _showTimer() {
    Timer? t;
    t = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        seconds--;
      });
      if (seconds == 0) {
        //清除定时器
        t!.cancel();

        setState(() {
          this.sendCodeBtn = true;
        });
      }
    });
  }

  //验证验证码

  validateCode() async {
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {"tel": tel, "code": code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerThird',
          arguments: {"tel": tel, "code": code});
    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("验证码已经发送到了您的${tel}手机，请输入${tel}手机号收到的验证码"),
            ),
            const SizedBox(height: 40),
            Stack(
              children: <Widget>[
                JdText(
                  text: "请输入验证码",
                  onChanged: (value) {
                    code = value;
                  },
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: sendCodeBtn
                        ? ElevatedButton(
                            onPressed: sendCode,
                            child: Text('重新发送'),
                          )
                        : ElevatedButton(
                            child: Text('${seconds}秒后重发'),
                            onPressed: () {},
                          ))
              ],
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: validateCode,
            )
          ],
        ),
      ),
    );
  }
}
