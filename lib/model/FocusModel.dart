class FocusModel {
  late List<FocusItemModel> result;
  FocusModel({required this.result});
  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusItemModel>[];
      json['result'].forEach((v) {
        result.add(FocusItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.map((v) => v.toJson()).toList();
    return data;
  }
}

class FocusItemModel {
  late String sId;
  late String title;
  late String status;
  late String pic;
  late String url;

  FocusItemModel(
      {required this.sId,
      required this.title,
      required this.status,
      required this.pic,
      required this.url});

  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['url'] = url;
    return data;
  }
}

// class FocusModel {
//   late String sId;
//   late String title;
//   late String status;
//   late String pic;
//   late String url;

//   FocusModel(
//       {required this.sId,
//       required this.title,
//       required this.status,
//       required this.pic,
//       required this.url});

//   FocusModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     status = json['status'];
//     pic = json['pic'];
//     url = json['url'];
//   }
// }
