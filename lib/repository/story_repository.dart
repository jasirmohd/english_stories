import 'package:english_stories/service/local_db_service.dart';

import '../model/story_db_model.dart';

class StoryRepository{

  final dbService = LocalDBService();

  Future addToDB(StoryDBModel model) async {
    await dbService.addStoryToDB(model);
  }

  Future getAllStory() async {
    List<StoryDBModel> list = await dbService.getDBStory();
    return list;
  }

  Future getAllFavouriteStory() async {
    List<StoryDBModel> list = await dbService.getDBStory();
    List<StoryDBModel> favouriteList = list.where((element) => element.isFavourite!).toList();
    return favouriteList;
  }

  Future getAllBookmarkStory() async {
    List<StoryDBModel> list = await dbService.getDBStory();
    List<StoryDBModel> bookmarkList = list.where((element) => element.isBookmarked!).toList();
    return bookmarkList;
  }

  Future getFavouriteFlag(String title, String category) async {
    List<StoryDBModel> list = await dbService.getDBStory();
    List<StoryDBModel> dataList = list.where((element) => element.category == category && element.title == title && element.isFavourite!).toList();
    if(dataList.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future getBookmarkFlag(String title,String category) async {
    List<StoryDBModel> list = await dbService.getDBStory();
    List<StoryDBModel> dataList = list.where((element) => element.category == category && element.title == title && element.isBookmarked!).toList();
    if(dataList.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future addFavouriteFlag(StoryDBModel storyDBModel) async {
    List<StoryDBModel> list= await getAllStory();
    int index = list.indexWhere((element) => element.category == storyDBModel.category && element.title == storyDBModel.title);
    if(index != -1) {
      await dbService.updateStoryListFromDB(index, storyDBModel);
    }else{
      await addToDB(storyDBModel);
    }
    return true;
  }

  Future addBookmarkFlag(StoryDBModel storyDBModel) async {
    List<StoryDBModel> list= await getAllStory();
    int index = list.indexWhere((element) => element.category == storyDBModel.category && element.title == storyDBModel.title);
    if(index != -1) {
      await dbService.updateStoryListFromDB(index, storyDBModel);
    }else{
      await addToDB(storyDBModel);
    }
    return true;
  }


  Future removeFavouriteFlag(StoryDBModel storyDBModel) async {
    List<StoryDBModel> list= await getAllStory();
    int index = list.indexWhere((element) => element.category == storyDBModel.category && element.title == storyDBModel.title);
    if(index != -1) {
      await dbService.updateStoryListFromDB(index, storyDBModel);
    }
      return true;
  }

  Future removeBookmarkFlag(StoryDBModel storyDBModel) async {
    List<StoryDBModel> list= await getAllStory();
    int index = list.indexWhere((element) => element.category == storyDBModel.category && element.title == storyDBModel.title);
    if(index != -1) {
      await dbService.updateStoryListFromDB(index, storyDBModel);
    }
      return true;
  }
}