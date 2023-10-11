import 'dart:developer';
import 'dart:io';

import 'package:english_stories/model/story_db_model.dart';
import 'package:english_stories/repository/story_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

class StoryController extends GetxController {
  static StoryController get to => Get.put(StoryController());

  final arguments = Get.arguments;

  final _repo = StoryRepository();

  final category = RxString('');
  final title = RxString('');
  final body = RxString('');
  final image = RxString('');

  final textSize = RxDouble(16.0);

  final isAudioPlaying = RxBool(false);

  final isBookmarked = RxBool(false);
  final isFavourite = RxBool(false);

  final FlutterTts _flutterTts = FlutterTts();

  BannerAd? bannerAd;
  final isLoaded = RxBool(false);

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  RewardedInterstitialAd? rewardeInterstitialdAd;

  // TODO: replace this test ad unit with your own ad unit.
  final videoAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';

  final AdSize adSize = const AdSize(width: 300, height: 50);

  final rewardScore = RxInt(0);

  @override
  void onInit() {
    category.value = arguments['category'];
    title.value = arguments['title'];
    body.value = arguments['body'];
    image.value = arguments['image'];
    update();
    loadVideoAd();
    loadAd();
    initFlutterTTS();
    loadBookmarked();
    super.onInit();
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

  /// Loads a rewarded ad.
  void loadVideoAd() {
    RewardedInterstitialAd.load(
        adUnitId: videoAdUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            rewardeInterstitialdAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ));
  }

  Future showRewardedAd() async {
    if(rewardeInterstitialdAd != null){
      rewardeInterstitialdAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          loadVideoAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          loadVideoAd();
      }
      );
      rewardeInterstitialdAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        rewardScore.value++;
      });
      rewardeInterstitialdAd = null;
    }
  }

  initFlutterTTS() {
    setTtsLanguage();
    _flutterTts.setStartHandler(() {
      log("playing");
      isAudioPlaying.value = true;
    });

    _flutterTts.setCompletionHandler(() {
      log("Complete");
      isAudioPlaying.value = false;
    });

    _flutterTts.setErrorHandler((msg) {
      log("error: $msg");
      isAudioPlaying.value = true;
    });
  }

  void setTtsLanguage() async {
    await _flutterTts.getLanguages;
    log('languages - ${await _flutterTts.getLanguages}');
    await _flutterTts.setLanguage("en-IN");
    await _flutterTts.setSpeechRate(0.3); //speed of speech
    await _flutterTts.setVolume(1.0); //volume of speech
    await _flutterTts.setPitch(1); //pitch of sound
  }

  loadBookmarked() async {
    isBookmarked.value =
        await _repo.getBookmarkFlag(title.value, category.value);
    isFavourite.value =
        await _repo.getFavouriteFlag(title.value, category.value);
  }

  onBookmarkTap() {
    if (isBookmarked.value) {
      isBookmarked.value = false;
      _repo.removeBookmarkFlag(StoryDBModel(
          category: category.value,
          title: title.value,
          body: body.value,
          isFavourite: isFavourite.value,
          isBookmarked: false));
    } else {
      isBookmarked.value = true;
      _repo.addBookmarkFlag(StoryDBModel(
          category: category.value,
          title: title.value,
          body: body.value,
          isFavourite: isFavourite.value,
          isBookmarked: true));
    }
  }

  onZoomIn() {
    if (textSize.value < 30) {
      textSize.value = textSize.value + 2;
    }
  }

  onZoomOut() {
    if (textSize.value > 8) {
      textSize.value = textSize.value - 2;
    }
  }

  onAudioPlayTap() async {
    setTtsLanguage();
    if (!isAudioPlaying.value) {
      var result = await _flutterTts.speak(body.value);
      if (result == 1) {
        isAudioPlaying.value = true;
        log('is playing');
      }
    } else {
      var result = await _flutterTts.stop();
      if (result == 1) {
        isAudioPlaying.value = false;
        log('is not playing');
      }
    }
  }

  onShareTap() {
    Share.share('${title.value}:\n\n${body.value}');
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  Future<bool> onBackPress() async {
    await showRewardedAd();
    Get.back();
    rewardeInterstitialdAd?.dispose();
    return true;
  }

  onBackTap() async {
    await showRewardedAd();
    rewardeInterstitialdAd?.dispose();
    Get.back();
  }

// onTextColorChangeTap() {
//   showDialog(
//       context: Get.context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Pick a color!'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//                 pickersEnabled: const <ColorPickerType, bool>{
//                   ColorPickerType.wheel: true,
//                   ColorPickerType.accent: false,
//                   ColorPickerType.primary: false,
//                 },
//                 onColorChanged: (value) {
//                   String color = value.hex.toString();
//                   textColor.value = color;
//                 }),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text('DONE'),
//               onPressed: () {
//                 Navigator.of(context).pop(); //dismiss the color picker
//               },
//             ),
//           ],
//         );
//       });
// }
//
// onBackgroundChangeTap() {
//   showDialog(
//       context: Get.context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Pick a color!'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//                 pickersEnabled: const <ColorPickerType, bool>{
//                   ColorPickerType.wheel: true,
//                   ColorPickerType.accent: false,
//                   ColorPickerType.primary: false,
//                 },
//                 onColorChanged: (value) {
//                   String color = value.hex.toString();
//                   backgroundColor.value = color;
//                 }),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text('DONE'),
//               onPressed: () {
//                 Navigator.of(context).pop(); //dismiss the color picker
//               },
//             ),
//           ],
//         );
//       });
// }
}
