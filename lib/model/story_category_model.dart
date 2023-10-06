import 'dart:convert';

StoryCategoryModel storyCategoryModelFromJson(String str) => StoryCategoryModel.fromJson(json.decode(str));

String storyCategoryModelToJson(StoryCategoryModel data) => json.encode(data.toJson());

class StoryCategoryModel {
  List<StoryCategoryData> data;

  StoryCategoryModel({
    required this.data,
  });

  factory StoryCategoryModel.fromJson(Map<String, dynamic> json) => StoryCategoryModel(
    data: List<StoryCategoryData>.from(json["data"].map((x) => StoryCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StoryCategoryData {
  String category;
  String image;

  StoryCategoryData({
    required this.category,
    required this.image,
  });

  factory StoryCategoryData.fromJson(Map<String, dynamic> json) => StoryCategoryData(
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "image": image,
  };
}