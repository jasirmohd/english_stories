import 'dart:developer';

import 'package:english_stories/model/story_db_model.dart';
import 'package:english_stories/model/story_response_model.dart';
import 'package:english_stories/repository/story_repository.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/utils/story_config.dart';
import 'package:get/get.dart';

class StoryListController extends GetxController {
  static StoryListController get to => Get.put(StoryListController());

  dynamic arguments = Get.arguments;

  final _repo = StoryRepository();

  final category = ''.obs;

  final storyList = RxList<StoryData>([]);
  final favouriteStoryList = RxList<StoryDBModel>([]);

  @override
  void onInit() {
    category.value = arguments['category'];
    getStory();
    super.onInit();
  }

  loadFavourite() async {
    favouriteStoryList.value = await _repo.getAllStory();
  }

  Future getStory() async {
    String storyCategoryJson = await StoryConfig().getStoryList(category.value);
    StoryModel storyModel = storyModelFromJson(storyCategoryJson);
    List<StoryData> stringList = storyModel.data;
    if (stringList.isNotEmpty) {
      log('length - ${stringList.length}');
      if (storyList.isNotEmpty) {
        storyList.clear();
      }
      for (int i = 0; i < favouriteStoryList.length; i++) {
        int index = stringList.indexWhere((element) =>
            element.category == favouriteStoryList[i].category &&
            element.title == favouriteStoryList[i].title);
        if (index != -1) {
          stringList.update(
              index,
              StoryData(
                  category: stringList[index].category,
                  title: stringList[index].title,
                  body: stringList[index].body,
                  isFavourite: stringList[index].isFavourite,
                  isBookmarked: stringList[index].isBookmarked));
        }
      }
      storyList.addAll(stringList);
      update();
    }
  }

  onItemTap(int index) {
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category": category.value,
      "title": storyList[index].title,
      "body": storyList[index].body,
      "image": ""
    });
  }

  onFavouriteTap(int index) {
    if (storyList[index].isFavourite) {
      _repo.removeBookmarkFlag(StoryDBModel(
          category: storyList[index].category,
          title: storyList[index].title,
          body: storyList[index].body,
          isFavourite: false,
          isBookmarked: storyList[index].isBookmarked));
      storyList.update(
          index,
          StoryData(
              category: storyList[index].category,
              title: storyList[index].title,
              body: storyList[index].body,
              isFavourite: false,
              isBookmarked: storyList[index].isBookmarked));
    } else {
      _repo.addBookmarkFlag(StoryDBModel(
          category: storyList[index].category,
          title: storyList[index].title,
          body: storyList[index].body,
          isFavourite: true,
          isBookmarked: storyList[index].isBookmarked));
      storyList.update(
          index,
          StoryData(
              category: storyList[index].category,
              title: storyList[index].title,
              body: storyList[index].body,
              isFavourite: true,
              isBookmarked: storyList[index].isBookmarked));
    }
  }
}

extension ListUpdate<T> on List<T> {
  List<T> update(int pos, T t) {
    List<T> list = [];
    list.add(t);
    replaceRange(pos, pos + 1, list);
    return this;
  }
}
