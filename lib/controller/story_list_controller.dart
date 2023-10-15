import 'dart:developer';
import 'dart:io';

import 'package:english_stories/model/story_db_model.dart';
import 'package:english_stories/repository/story_repository.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StoryListController extends GetxController {
  static StoryListController get to => Get.put(StoryListController());

  dynamic arguments = Get.arguments;

  final _repo = StoryRepository();

  final category = ''.obs;

  final storyList = RxList<StoryDBModel>([]);
  final favouriteStoryList = RxList<StoryDBModel>([]);

  BannerAd? bannerAd;
  final isLoaded = RxBool(false);

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  final AdSize adSize = const AdSize(width: 300, height: 50);

  @override
  void onInit() {
    category.value = arguments['category'];
    storyList.value = arguments['story_list'];
    loadFavourite();
    loadAd();
    super.onInit();
  }

  loadFavourite() async {
    favouriteStoryList.value = await _repo.getAllFavouriteStory();
  }

  onItemTap(int index) {
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category": category.value,
      "title": storyList[index].title,
      "body": storyList[index].body,
      "image": "",
      "one_day_story":false
    });
  }

  onFavouriteTap(int index) async {
    if (storyList[index].isFavourite!) {
      log('is not favourite - ${storyList[index].title} ${storyList[index].isFavourite}');
      StoryDBModel storyDBModel = StoryDBModel(
        category: storyList[index].category,
        title: storyList[index].title,
        body: storyList[index].body,
        isFavourite: false,
        isBookmarked: storyList[index].isBookmarked,
        isUnRead: storyList[index].isUnRead,
        imageUrl: storyList[index].imageUrl,
        storyImageUrl: storyList[index].storyImageUrl,);
      await _repo.removeFavouriteFlag(storyDBModel);
      storyList.insert(index,storyDBModel);
      storyList.removeAt(index+1);
      storyList.refresh();
    } else {
      log('is favourite - ${storyList[index].title} ${storyList[index].isFavourite}');
      StoryDBModel storyDBModel = StoryDBModel(
        category: storyList[index].category,
        title: storyList[index].title,
        body: storyList[index].body,
        isFavourite: true,
        isBookmarked: storyList[index].isBookmarked,
        isUnRead: storyList[index].isUnRead,
        imageUrl: storyList[index].imageUrl,
        storyImageUrl: storyList[index].storyImageUrl,);
      await _repo.addFavouriteFlag(storyDBModel);
      storyList.insert(index, storyDBModel);
      storyList.removeAt(index+1);
      storyList.refresh();
    }
  }

  /// Loads a banner ad.
  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }
}

