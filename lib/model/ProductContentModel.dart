// To parse this JSON data, do
//
//     final productContentModel = productContentModelFromJson(jsonString);

import 'dart:convert';

ProductContentModel productContentModelFromJson(String str) =>
    ProductContentModel.fromJson(json.decode(str));

String productContentModelToJson(ProductContentModel data) =>
    json.encode(data.toJson());

class ProductContentModel {
  ProductItemModel result;

  ProductContentModel({
    required this.result,
  });

  factory ProductContentModel.fromJson(Map<String, dynamic> json) =>
      ProductContentModel(
        result: ProductItemModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class ProductItemModel {
  String id;
  String title;
  String cid;
  dynamic price;
  dynamic oldPrice;
  dynamic isBest;
  dynamic isHot;
  dynamic isNew;
  dynamic status;
  String pic;
  String content;
  String cname;
  List<Attr> attr;
  String subTitle;
  int salecount;

  ProductItemModel({
    required this.id,
    required this.title,
    required this.cid,
    required this.price,
    required this.oldPrice,
    required this.isBest,
    required this.isHot,
    required this.isNew,
    required this.status,
    required this.pic,
    required this.content,
    required this.cname,
    required this.attr,
    required this.subTitle,
    required this.salecount,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        id: json["_id"],
        title: json["title"],
        cid: json["cid"],
        price: json["price"],
        oldPrice: json["old_price"],
        isBest: json["is_best"],
        isHot: json["is_hot"],
        isNew: json["is_new"],
        status: json["status"],
        pic: json["pic"],
        content: json["content"],
        cname: json["cname"],
        attr: List<Attr>.from(json["attr"].map((x) => Attr.fromJson(x))),
        subTitle: json["sub_title"],
        salecount: json["salecount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "cid": cid,
        "price": price,
        "old_price": oldPrice,
        "is_best": isBest,
        "is_hot": isHot,
        "is_new": isNew,
        "status": status,
        "pic": pic,
        "content": content,
        "cname": cname,
        "attr": List<dynamic>.from(attr.map((x) => x.toJson())),
        "sub_title": subTitle,
        "salecount": salecount,
      };
}

class Attr {
  String cate;
  List<String> list;

  Attr({
    required this.cate,
    required this.list,
  });

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        cate: json["cate"],
        list: List<String>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cate": cate,
        "list": List<dynamic>.from(list.map((x) => x)),
      };
}
