import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignServices {
  static getSign() {
    Map addressListAttr = {
      "uid": '1',
      "age": 10,
      "salt": 'xxxxxxxxxxxxxx' //私钥
    };
    List attrKeys = addressListAttr.keys.toList();
    attrKeys.sort(); //排序  ASCII 字符顺序进行升序排列
    print(attrKeys);
    String str = '';
    for (var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${addressListAttr[attrKeys[i]]}";
    }
    // print(str);
    print(md5.convert(utf8.encode(str)));
  }
}
