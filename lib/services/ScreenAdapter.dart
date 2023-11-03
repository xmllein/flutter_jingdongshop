import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 适配屏幕类

class ScreenAdapter {
  static init(context) {
    // 初始化屏幕适配
    ScreenUtil.init(context, designSize: const Size(750, 1334));
  }

  // 高度
  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  // 宽度
  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  // 获取物理高度
  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  // 获取物理宽度
  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  // 文字
  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
