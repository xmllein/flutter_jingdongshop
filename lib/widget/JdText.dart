import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final void Function(String)? onChanged;

  JdText(
      {Key? key,
      this.text = "输入内容",
      this.password = false,
      this.onChanged = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(68),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: TextField(
        obscureText: password,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: onChanged,
      ),
    );
  }
}
