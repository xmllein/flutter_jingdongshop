// To parse this JSON data, do
//
//     final cateModel = cateModelFromJson(jsonString);

import 'dart:convert';

CateModel cateModelFromJson(String str) => CateModel.fromJson(json.decode(str));

String cateModelToJson(CateModel data) => json.encode(data.toJson());

class CateModel {
  List<Result> result;

  CateModel({
    required this.result,
  });

  factory CateModel.fromJson(Map<String, dynamic> json) => CateModel(
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
  dynamic status;
  String pic;
  String pid;
  String sort;

  Result({
    required this.id,
    required this.title,
    required this.status,
    required this.pic,
    required this.pid,
    required this.sort,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        title: json["title"],
        status: json["status"],
        pic: json["pic"],
        pid: json["pid"],
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "status": status,
        "pic": pic,
        "pid": pid,
        "sort": sort,
      };
}
