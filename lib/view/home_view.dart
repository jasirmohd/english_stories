import 'dart:developer';

import 'package:english_stories/controller/home_controller.dart';
import 'package:english_stories/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.theme});

  final bool theme;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: ListView(
          children: [
            // _adContentWidget(context, controller),
            _contentWidget(context, controller),
          ],
        ),
      ),
    );
  }



  Widget _contentWidget(BuildContext context, HomeController controller) {
    return SizedBox(
      child: Obx(
        () => ListView.builder(
            itemCount: controller.storyCategoryList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _itemWidget(context, index, controller);
            }),
      ),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, HomeController controller) {
    return InkWell(
      onTap: () => controller.onItemTap(index),
      child: Card(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    flex: 0,
                    child: Container(
                      height: 90,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(image: AssetImage(controller.storyCategoryList[index]))
                      ),
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      controller.storyCategoryList[index],
                      style: Theme.of(context).textTheme.titleMedium,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _adContentWidget(BuildContext context, HomeController controller){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() => !controller.nativeAdIsLoaded.value ? const SizedBox() : ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320, // minimum recommended width
          minHeight: 90, // minimum recommended height
          maxWidth: 400,
          maxHeight: 200,
        ),
        child: AdWidget(ad: controller.nativeAd!),
      )),
    );
  }
}
