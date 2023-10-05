import 'dart:developer';

import 'package:english_stories/model/story_response_model.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/utils/story_config.dart';
import 'package:get/get.dart';

class StoryListController extends GetxController{
  static StoryListController get to => Get.put(StoryListController());

  dynamic arguments = Get.arguments;

  final category = ''.obs;

  final storyList = RxList<StoryData>([]);

  @override
  void onInit() {
    category.value = arguments['category'];
    getStory();
    super.onInit();
  }

  Future getStory() async {
    String storyCategoryJson = await StoryConfig().getStoryList(category.value);
    StoryModel storyModel = storyModelFromJson(storyCategoryJson);
    List<StoryData> stringList = storyModel.data;
    if(stringList.isNotEmpty) {
      log('length - ${stringList.length}');
      if (storyList.isNotEmpty) {
        storyList.clear();
      }
      storyList.addAll(stringList);
      update();
    }
  }

  onItemTap(int index){
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category":category.value,
      "title":storyList[index].title,
      "body":storyList[index].body,
      "image_url":""
    });
  }
}