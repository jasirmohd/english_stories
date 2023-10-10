import 'dart:developer';
import 'dart:io';

import 'package:english_stories/model/story_category_model.dart';
import 'package:english_stories/resources/app_assets.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController{
  static HomeController get to => Get.put(HomeController());

  final storyCategoryList = RxList<StoryCategoryData>([]);

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  void onInit() {
    getStoryCategory();
    loadAd();
    super.onInit();
  }

  Future getStoryCategory() async {
    String storyCategoryJson = await rootBundle.loadString(AppAssets.storyCategory);
    StoryCategoryModel storyModel = storyCategoryModelFromJson(storyCategoryJson);
    List<StoryCategoryData> stringList = storyModel.data;
    if(stringList.isNotEmpty) {
      log('length - ${stringList.length}');
      if (storyCategoryList.isNotEmpty) {
        storyCategoryList.clear();
      }
      storyCategoryList.addAll(stringList);
      update();
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

  onItemTap(int index){
    Get.toNamed(RouteUtils.storyListView, arguments: {"category":storyCategoryList[index].category});
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}