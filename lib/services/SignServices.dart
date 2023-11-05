import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignServices {
  static getSign(json) {
    List attrKeys = json.keys.toList();
    attrKeys.sort(); //排序  ASCII 字符顺序进行升序排列
    String str = '';
    for (var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${json[attrKeys[i]]}";
    }
    return md5.convert(utf8.encode(str)).toString();
  }
}
