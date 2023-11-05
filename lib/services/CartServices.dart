import 'dart:convert';

import 'package:flutter_jdshop/services/Storage.dart';

import '../config/Config.dart';

class CartServices {
  static addCart(item) async {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    // 获取本地储存的数据
    try {
      List cartListData =
          json.decode(await Storage.getString('cartList') as String);
      //  判断是否有重复数据
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] &&
            value['selectedAttr'] == item['selectedAttr'];
      });

      // 有数据
      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['_id'] &&
              cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]['count'] = cartListData[i]['count'] + 1;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      // 临时变量
      List tempList = [];
      tempList.add(item);
      print(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //过滤数据
  static formatCartData(item) {
    // 处理图片

    final Map data = <String, dynamic>{};
    data['_id'] = item.id;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
