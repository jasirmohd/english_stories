import 'package:device_preview/device_preview.dart';
import 'package:english_stories/resources/app_theme.dart';
import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/utils/shared_pref_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';
import 'model/story_db_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  WidgetsFlutterBinding.ensureInitialized();
  await initDB();
  await SharedPrefUtils().init();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) =>  MyApp(),
    ),
  );
}

Future initDB() async {
  await Hive.initFlutter();
  await Hive.openBox<StoryDBModel>('story_box');
  Hive.registerAdapter(StoryDBModelAdapter());
}

class MyApp extends StatelessWidget {
  RxBool isLight = false.obs;

  getThemeData(){
    isLight.value = SharedPrefUtils().getThemeStatus();
    Get.changeThemeMode(isLight.value ? ThemeMode.light : ThemeMode.dark);
  }

  // This widget is the root of your application.

  MyApp(){
    getThemeData();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'English Stories',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: RouteUtils().pages,
      initialRoute: RouteUtils.splashView,
    );
  }
}
