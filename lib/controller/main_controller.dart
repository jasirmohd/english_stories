import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/shared_pref_utils.dart';

class MainController extends GetxController{
  static MainController get to => Get.put(MainController());

  final scaffoldState = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  final isLight = RxBool(false);

  @override
  onInit(){
    isLight.value = SharedPrefUtils().getThemeStatus();
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

}