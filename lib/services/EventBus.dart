import 'package:event_bus/event_bus.dart';

//Bus 初始化

EventBus eventBus = EventBus();

//商品详情广播数据
class ProductContentEvent {
  String str;

  ProductContentEvent(this.str);
}

//用户中心广播
class UserEvent {
  String str;

  UserEvent(this.str);
}

// 添加收货地址
class AddressEvent {
  String str;

  AddressEvent(this.str);
}

//结算页面
class CheckOutEvent {
  String str;

  CheckOutEvent(this.str);
}
