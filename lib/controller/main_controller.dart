import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  static MainController get to => Get.put(MainController());

  final scaffoldState = GlobalKey<ScaffoldState>();

  int currentIndex = 0;


  onItemTap(int index){
    currentIndex = index;
    update();
  }

}