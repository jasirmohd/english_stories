import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../model/one_day_story_response_model.dart';
import '../utils/route_utils.dart';

class RandomStoryController extends GetxController{
  static RandomStoryController get to => Get.put(RandomStoryController());

  final _db = FirebaseFirestore.instance;

  final oneDayTitle = ''.obs;
  final onDayImage = ''.obs;
  final onDayCategory = ''.obs;
  final onDayBody = ''.obs;

  final oneDayStoryVisibility = RxBool(false);

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  onInit(){
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getOneDayStoryFromApi(currentDate);
    loadAd();
    super.onInit();
  }

  Future getOneDayStoryFromApi(String date) async {
    final snapshot = await _db.collection('one_day_story').where("date", isEqualTo: date).get();
    final oneDayStoryData = snapshot.docs.map((e) => OneDayStoryResponseModel.fromSnapshot(e));
    if(oneDayStoryData.isNotEmpty) {
      oneDayStoryVisibility.value = true;
      oneDayTitle.value = oneDayStoryData.single.title;
      onDayImage.value = oneDayStoryData.single.imageUrl;
      onDayBody.value = oneDayStoryData.single.body;
      onDayCategory.value = oneDayStoryData.single.category;
    }else{
      oneDayStoryVisibility.value = false;
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

  onOneDayStoryTap(){
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category":onDayCategory.value,
      "title":oneDayTitle.value,
      "body":onDayBody.value,
      "image_url":onDayImage.value
    });
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

}