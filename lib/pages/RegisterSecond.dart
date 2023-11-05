import 'package:flutter/material.dart';

import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';

class RegisterSecondPage extends StatefulWidget {
  const RegisterSecondPage({super.key});

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
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
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("请输入xxx手机收到的验证码,请输入xxx手机收到的验证码"),
            ),
            SizedBox(height: 40),
            Stack(
              children: <Widget>[
                JdText(
                  text: "请输入验证码",
                  onChanged: (value) {
                    print(value);
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: ElevatedButton(
                    child: Text('重新发送'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: () {
                Navigator.pushNamed(context, '/registerThird');
              },
            )
          ],
        ),
      ),
    );
  }
}
