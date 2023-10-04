import 'package:english_stories/controller/splash_controller.dart';
import 'package:english_stories/resources/app_strings.dart';
import 'package:english_stories/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder:(controller) => Scaffold(
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonTextWidget(text: AppStrings.appName, textSize: 16,),
              CommonTextWidget(text: AppStrings.appVersion, textSize: 10.0,)
            ],
          ),
        ),
      ),
    );
  }
}
