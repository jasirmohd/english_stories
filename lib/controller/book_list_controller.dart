import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_stories/model/books_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class BookListController extends GetxController{
  static BookListController get to => Get.put(BookListController());

  final _db = FirebaseFirestore.instance;

  final bookList = RxList<BookResponseModel>([]);

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  onInit(){
    getBooksListFromApi();
    loadAd();
    super.onInit();
  }

  Future getBooksListFromApi() async {
    final snapshot = await _db.collection('books').get();
    final list = snapshot.docs.map((e) => BookResponseModel.fromSnapshot(e));
    if(list.isNotEmpty) {
     if(bookList.isNotEmpty){
       bookList.clear();
     }
     bookList.addAll(list);
     bookList.refresh();
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
          templateType: TemplateType.small,
          // Optional: Customize the ad's style.
          cornerRadius: 10.0,
        ))
      ..load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}