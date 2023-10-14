import 'dart:io';

import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DictionaryController extends GetxController{

  final recentSearchList = RxList([]);

  final searchController = TextEditingController();

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';
  
  @override
  void onInit() {
    recentSearchList.addAll(SharedPrefUtils().getRecentWords());
    loadAd();
    super.onInit();
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
  
  onSearchTap(){
    Get.toNamed(RouteUtils.dictionarySearchView, arguments: {"word":searchController.text});
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}