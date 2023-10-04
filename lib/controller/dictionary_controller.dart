import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController{
  static DictionaryController get to => Get.put(DictionaryController());

  final searchWordController = TextEditingController();
}