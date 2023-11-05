// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool success;
  String message;
  List<Result> result;

  OrderModel({
    required this.success,
    required this.message,
    required this.result,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String id;
  String uid;
  String name;
  String phone;
  String address;
  String allPrice;
  int payStatus;
  int orderStatus;
  List<OrderItem> orderItem;

  Result({
    required this.id,
    required this.uid,
    required this.name,
    required this.phone,
    required this.address,
    required this.allPrice,
    required this.payStatus,
    required this.orderStatus,
    required this.orderItem,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        allPrice: json["all_price"],
        payStatus: json["pay_status"],
        orderStatus: json["order_status"],
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "name": name,
        "phone": phone,
        "address": address,
        "all_price": allPrice,
        "pay_status": payStatus,
        "order_status": orderStatus,
        "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
      };
}

class OrderItem {
  String id;
  String orderId;
  String productTitle;
  String productId;
  int productPrice;
  String productImg;
  int productCount;
  String selectedAttr;
  int addTime;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productTitle,
    required this.productId,
    required this.productPrice,
    required this.productImg,
    required this.productCount,
    required this.selectedAttr,
    required this.addTime,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["_id"],
        orderId: json["order_id"],
        productTitle: json["product_title"],
        productId: json["product_id"],
        productPrice: json["product_price"],
        productImg: json["product_img"],
        productCount: json["product_count"],
        selectedAttr: json["selected_attr"],
        addTime: json["add_time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_id": orderId,
        "product_title": productTitle,
        "product_id": productId,
        "product_price": productPrice,
        "product_img": productImg,
        "product_count": productCount,
        "selected_attr": selectedAttr,
        "add_time": addTime,
      };
}
