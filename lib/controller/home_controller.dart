import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_stories/model/one_day_story_response_model.dart';
import 'package:english_stories/resources/app_assets.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController{
  static HomeController get to => Get.put(HomeController());

  final _db = FirebaseFirestore.instance;

  final storyCategoryList = RxList<String>([]);

  final oneDayTitle = ''.obs;
  final onDayImage = ''.obs;
  final onDayCategory = ''.obs;
  final onDayBody = ''.obs;

  @override
  void onInit() {
    getStoryCategory();
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getOneDayStoryFromApi(currentDate);
    super.onInit();
  }

  Future getStoryCategory() async {
    String storyCategoryJson = await rootBundle.loadString(AppAssets.storyCategory);
    final Map<String, dynamic> data = json.decode(storyCategoryJson);
    List<String>? stringList = [];
    stringList = (data['data'] as List).map((item) => item as String).toList();
    if(stringList.isNotEmpty) {
      log('length - ${stringList.length}');
      if (storyCategoryList.isNotEmpty) {
        storyCategoryList.clear();
      }
      storyCategoryList.addAll(stringList);
      update();
    }
  }

  Future getOneDayStoryFromApi(String date) async {
    final snapshot = await _db.collection('one_day_story').where("date", isEqualTo: date).get();
    final oneDayStoryData = snapshot.docs.map((e) => OneDayStoryResponseModel.fromSnapshot(e)).single;
    oneDayTitle.value = oneDayStoryData.title;
    onDayImage.value = oneDayStoryData.imageUrl;
    onDayBody.value = oneDayStoryData.body;
    onDayCategory.value = oneDayStoryData.category;
  }

  onOneDayStoryTap(){
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category":onDayCategory.value,
      "title":oneDayTitle.value,
      "body":onDayBody.value,
      "image_url":onDayImage.value
    });
  }

  onItemTap(int index){
    Get.toNamed(RouteUtils.storyListView, arguments: {"category":storyCategoryList[index]});
  }
}