import 'dart:async';

import 'package:english_stories/utils/route_utils.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  static SplashController get to => Get.put(SplashController());

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => Get.toNamed(RouteUtils.mainView));
    super.onInit();
  }
}