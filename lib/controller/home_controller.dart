import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darq/darq.dart';
import 'package:english_stories/model/story_db_model.dart';
import 'package:english_stories/model/story_response_model.dart';
import 'package:english_stories/repository/story_repository.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());

  final _repo = StoryRepository();

  final _db = FirebaseFirestore.instance;

  final storyCategoryList = RxList<String>([]);

  final storyList = RxList<StoryDBModel>([]);

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  final currentDate = RxString('');

  @override
  void onInit() {
    currentDate.value = SharedPrefUtils().getDate();
    getStoryCategory();
    loadAd();
    super.onInit();
  }

  Future getStoryCategory() async {
    String dateTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String date = dateTime.replaceAll('/', '');
    List<StoryResponseModel> responseList = [];
    List<StoryDBModel> dbStoryList = await _repo.getAllStory();
    if(currentDate.value != date) {
      SharedPrefUtils().saveDate = date;
      final snapshot = await _db.collection('story').get();
      responseList =
      snapshot.docs.map((e) => StoryResponseModel.fromSnapshot(e)).toList();
    }
    await loadStoryCategoryFromDB(responseList, dbStoryList);
  }

  Future loadStoryCategoryFromDB(List<StoryResponseModel> responseList, List<StoryDBModel> dbStoryList) async{
    if (responseList.isNotEmpty) {
      if(dbStoryList.isNotEmpty){
        for(int i=0; i < dbStoryList.length; i++){
          responseList.removeWhere((element) => element.category == dbStoryList[i].category && element.title == dbStoryList[i].title);
        }
      }
      storyList.value = dbStoryList;
      for (int i = 0; i < responseList.length; i++) {
        StoryDBModel storyDBModel = StoryDBModel(
            category: responseList[i].category,
            title: responseList[i].title,
            body: responseList[i].body,
            isFavourite: false,
            isBookmarked: false,
            isUnRead: false,
            imageUrl: responseList[i].imageUrl,
            storyImageUrl: responseList[i].storyImageUrl);
        await _repo.addToDB(storyDBModel);
        storyList.add(storyDBModel);
      }
      final categoryList =
      storyList.distinct((e) => e.category.toString()).toList();
      for (int j = 0; j < categoryList.length; j++) {
        storyCategoryList.add(categoryList[j].category.toString());
      }
      storyCategoryList.refresh();

    }
  }

  /// Loads a native ad.
  void loadAd() {
    nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            nativeAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
          templateType: TemplateType.medium,
          // Optional: Customize the ad's style.
          cornerRadius: 10.0,
        ))
      ..load();
  }

  onItemTap(int index) {
    final list = storyList
        .where((e) => e.category.toString() == storyCategoryList[index])
        .toList();
    Get.toNamed(RouteUtils.storyListView,
        arguments: {"category": storyCategoryList[index], "story_list": list});
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}
