import 'dart:developer';

import 'package:english_stories/model/story_db_model.dart';
import 'package:english_stories/repository/story_repository.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

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

  final textColor = RxString('');
  final backgroundColor = RxString('');

  final isBookmarked = RxBool(false);
  final isFavourite = RxBool(false);

  final FlutterTts _flutterTts = FlutterTts();

  @override
  void onInit() {
    category.value = arguments['category'];
    title.value = arguments['title'];
    body.value = arguments['body'];
    image.value = arguments['image'];
    textColor.value =
        Theme.of(Get.context!).textTheme.titleMedium!.color.toString();
    backgroundColor.value =
        Theme.of(Get.context!).colorScheme.background.toString();
    update();
    initFlutterTTS();
    super.onInit();
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

  onTextColorChangeTap() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.wheel: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.primary: false,
                  },
                  onColorChanged: (value) {
                    String color = value.hex.toString();
                    textColor.value = color;
                  }),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('DONE'),
                onPressed: () {
                  Navigator.of(context).pop(); //dismiss the color picker
                },
              ),
            ],
          );
        });
  }

  onBackgroundChangeTap() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.wheel: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.primary: false,
                  },
                  onColorChanged: (value) {
                    String color = value.hex.toString();
                    backgroundColor.value = color;
                  }),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('DONE'),
                onPressed: () {
                  Navigator.of(context).pop(); //dismiss the color picker
                },
              ),
            ],
          );
        });
  }
}
