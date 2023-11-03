// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<Result> result;

  ProductModel({
    required this.result,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String id;
  String title;
  String cid;
  dynamic price;
  dynamic oldPrice;
  String pic;
  String sPic;

  Result({
    required this.id,
    required this.title,
    required this.cid,
    required this.price,
    required this.oldPrice,
    required this.pic,
    required this.sPic,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        title: json["title"],
        cid: json["cid"],
        price: json["price"],
        oldPrice: json["old_price"],
        pic: json["pic"],
        sPic: json["s_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "cid": cid,
        "price": price,
        "old_price": oldPrice,
        "pic": pic,
        "s_pic": sPic,
      };
}
