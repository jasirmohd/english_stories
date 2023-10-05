import 'dart:convert';

StoryModel storyModelFromJson(String str) => StoryModel.fromJson(json.decode(str));

String storyModelToJson(StoryModel data) => json.encode(data.toJson());

class StoryModel {
  List<StoryData> data;

  StoryModel({
    required this.data,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    data: List<StoryData>.from(json["data"].map((x) => StoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StoryData {
  String category;
  String title;
  String body;

  StoryData({
    required this.category,
    required this.title,
    required this.body,
  });

  factory StoryData.fromJson(Map<String, dynamic> json) => StoryData(
    category: json["category"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "title": title,
    "body": body,
  };
}
