import 'package:hive_flutter/hive_flutter.dart';

import '../model/story_db_model.dart';

class LocalDBService{


  Future addStoryToDB(StoryDBModel model) async {
    Box<StoryDBModel> box = Hive.box<StoryDBModel>('story_box');
    box.add(model);
  }

  Future<List<StoryDBModel>> getDBStory() async {
    Box<StoryDBModel> box = Hive.box<StoryDBModel>('story_box');
    List<StoryDBModel> list = box.values.toList();
    return list;
  }

  Future deleteStoryFromDB(String title, String category) async {
    Box<StoryDBModel> box = Hive.box<StoryDBModel>('story_box');
    List<StoryDBModel> list = box.values.toList();
    int index = list.indexWhere((element) => element.title == title && element.category == category);
    if(index != -1){
      box.deleteAt(index);
    }
  }

  Future updateStoryListFromDB(int index, StoryDBModel storyDBModel) async {
    Box<StoryDBModel> box = Hive.box<StoryDBModel>('story_box');
    await box.putAt(index, storyDBModel);
  }
}