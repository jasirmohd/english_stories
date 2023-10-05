import 'package:hive/hive.dart';

part 'story_db_model.g.dart';

@HiveType(typeId: 1)
class StoryDBModel {
  StoryDBModel({this.id,this.category,this.title, this.body,this.isFavourite, this.isBookmarked});

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? category;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? body;

  @HiveField(4)
  bool? isFavourite;

  @HiveField(5)
  bool? isBookmarked;
}