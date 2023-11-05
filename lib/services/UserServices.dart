import 'dart:convert';

import 'Storage.dart';

class UserServices {
  // 获取用户信息
  static getUserInfo() async {
    List userinfo;
    try {
      List userInfoData =
          json.decode(await Storage.getString('userInfo') as String);
      userinfo = userInfoData;
    } catch (e) {
      userinfo = [];
    }
    return userinfo;
  }

  // 用户登录状态
  static getUserLoginState() async {
    var userInfo = await UserServices.getUserInfo();
    if (userInfo.length > 0 && userInfo[0]["username"] != "") {
      return true;
    }
    return false;
  }

  // 退出登录
  static loginOut() {
    Storage.remove('userInfo');
  }
}
