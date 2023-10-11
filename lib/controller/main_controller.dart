import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/shared_pref_utils.dart';
import '../widgets/common_native_ads_widget.dart';

class MainController extends GetxController{
  static MainController get to => Get.put(MainController());

  final scaffoldState = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  final isLight = RxBool(false);

  NativeAd? nativeAd;
  final nativeAdIsLoaded = RxBool(false);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  onInit(){
    isLight.value = SharedPrefUtils().getThemeStatus();
    loadAd();
    super.onInit();
  }


  onItemTap(int index){
    currentIndex = index;
    update();
  }

  onThemeIconTap(){
    isLight.value = !isLight.value;
    SharedPrefUtils().saveThemeStatus = isLight.value;
    Get.changeThemeMode(isLight.value ? ThemeMode.light : ThemeMode.dark);
  }

  onBackPressed() async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text('Close'),
          content: Container(
            width: 340,
            height: 250,
            child: Column(
              children: [
                const Text('Are you sure you want to close the app?'),
                Obx(() => !nativeAdIsLoaded.value
                    ? const SizedBox()
                    : Container(
                  width: 320,
                  height: 200,
                  child: AdWidget(ad: nativeAd!),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(onPressed: () => Get.back(), child: Text('Cancel', style: Theme.of(context).textTheme.titleSmall,), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
            ),),
            ElevatedButton(
              child: const Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              onPressed: () {
                Navigator.of(context).pop(); //dismiss the color picker
              },
            ),
          ],
        );
      });
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

}