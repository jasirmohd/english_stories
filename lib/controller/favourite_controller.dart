import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:darq/darq.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../model/story_db_model.dart';
import '../repository/story_repository.dart';

class FavouriteController extends GetxController {
  static FavouriteController get to => Get.put(FavouriteController());

  final _repo = StoryRepository();

  final favouriteList = RxList<StoryDBModel>([]);

  final noData = RxString('');

  BannerAd? bannerAd;
  final isLoaded = RxBool(false);

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  final AdSize adSize = const AdSize(width: 300, height: 50);

  @override
  void onInit() {
    loadFavouriteStories();
    loadAd();
    super.onInit();
  }

  loadFavouriteStories() async {
    List<StoryDBModel> dataList = await _repo.getAllFavouriteStory();
    favouriteList.addAll(dataList.distinct((e) => e.category!));
    favouriteList.refresh();
    if (favouriteList.isEmpty) {
      noData.value = 'No Favourite stories';
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
