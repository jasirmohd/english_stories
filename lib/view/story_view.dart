import 'package:english_stories/controller/story_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/common_banner_ads_widget.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(),
      builder: (controller) => WillPopScope(
        onWillPop: controller.onBackPress,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Expanded(flex: 0, child: _appBarWidget(context, controller)),
              Expanded(flex: 1, child: _mainContentWidget(context, controller)),
              Expanded(flex: 0, child: _bottomContentWidget(context, controller)),
              Expanded(flex: 0, child: _bannerAdsWidget(context, controller))
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarWidget(BuildContext context, StoryController controller) {
    return AppBar(
      leading: IconButton(
          onPressed: () => controller.onBackTap(),
          icon: const Icon(
            Icons.arrow_back,
          )),
      title: Text(controller.storyDataList[0].category!,
          style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      actions: [
        Obx(
          () => IconButton(
              onPressed: () => controller.onBookmarkTap(),
              icon: Icon(
                controller.isBookmarked.value
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_add_outlined,
              )),
        )
      ],
    );
  }

  Widget _mainContentWidget(BuildContext context, StoryController controller) {
    return Column(
      children: [
        Expanded(
            flex: 0,
            child: Text(controller.storyDataList[0].title!,
                style: Theme.of(context).textTheme.titleSmall)),
        Expanded(
          flex: 1,
          child: Card(
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    () => Text(
                      controller.storyDataList[0].body!,
                      style: TextStyle(
                        fontSize: controller.textSize.value,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))),
          ),
        ),
      ],
    );
  }

  Widget _bottomContentWidget(
      BuildContext context, StoryController controller) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.onZoomOut(),
              icon: const Icon(
                Icons.zoom_out_rounded,
                size: 35,
              )),
          IconButton(
              onPressed: () => controller.onZoomIn(),
              icon: const Icon(
                Icons.zoom_in_rounded,
                size: 35,
              )),
          IconButton(
              onPressed: () => controller.onAudioPlayTap(),
              icon: const Icon(
                Icons.record_voice_over_rounded,
                size: 35,
              )),
          IconButton(
              onPressed: () => controller.onShareTap(),
              icon: const Icon(
                Icons.ios_share_rounded,
                size: 35,
              )),
          // IconButton(
          //     onPressed: () => controller.onTextColorChangeTap(),
          //     icon: const Icon(
          //       Icons.format_color_text_rounded,
          //       size: 35,
          //     )),
          // IconButton(
          //     onPressed: () => controller.onBackgroundChangeTap(),
          //     icon: const Icon(
          //       Icons.color_lens_rounded,
          //       size: 35,
          //     )),
        ],
      ),
    );
  }

  Widget _bannerAdsWidget(BuildContext context, StoryController controller) {
    return Obx(
      () => controller.isLoaded.value
          ? CommonBannerAdsWidget(
              width: controller.adSize.width,
              height: controller.adSize.height,
              bannerAd: controller.bannerAd!,
            )
          : const SizedBox(),
    );
  }
}
