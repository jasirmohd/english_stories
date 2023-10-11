import 'package:english_stories/widgets/common_native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/random_story_controller.dart';

class RandomStoryView extends StatelessWidget {
  const RandomStoryView({super.key, required this.theme});

  final bool theme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RandomStoryController>(
      init: RandomStoryController(),
      builder: (controller) => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: ListView(
          children: [
            Obx(() => Visibility(
                visible: controller.oneDayStoryVisibility.value,
                child: _oneDayStoryWidget(context, controller))),
            _adContentWidget(context, controller)
          ],
        ),
      ),
    );
  }

  Widget _oneDayStoryWidget(
      BuildContext context, RandomStoryController controller) {
    return InkWell(
      onTap: () => controller.onOneDayStoryTap(),
      child: Card(
        child: SizedBox(
          height: 200,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 160,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black,
                      ),
                    )),
                Expanded(
                    flex: 0,
                    child: Text(
                      controller.oneDayTitle.value,
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _adContentWidget(
      BuildContext context, RandomStoryController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() => !controller.nativeAdIsLoaded.value
          ? const SizedBox()
          : CommonNativeAdsWidget(isSmall: false,
              nativeAd: controller.nativeAd!,
            )),
    );
  }
}
