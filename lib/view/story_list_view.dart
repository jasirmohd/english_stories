import 'dart:developer';

import 'package:english_stories/controller/story_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/common_banner_ads_widget.dart';

class StoryListView extends StatefulWidget {
  const StoryListView({super.key});

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryListController>(
      init: StoryListController(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _headContentWidget(context, controller),
        body: Column(
          children: [
            Expanded(flex: 1, child: _contentWidget(context, controller)),
            Expanded(flex: 0, child: _bannerAdsWidget(context, controller))
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _headContentWidget(
      BuildContext context, StoryListController controller) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          )),
      title: Text(controller.category.value,style: Theme.of(context).textTheme.titleMedium,),
      centerTitle: true,
    );
  }

  Widget _contentWidget(BuildContext context, StoryListController controller) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.storyList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _itemWidget(context, index, controller);
          }),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, StoryListController controller) {
    log('favourite - ${controller.storyList[index].isFavourite}');
    return InkWell(
      onTap: () => controller.onItemTap(index),
      child: Card(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(controller.storyList[index].title, style: Theme.of(context).textTheme.titleSmall,)),
                Expanded(
                    flex: 0,
                    child: Obx(
                        () => IconButton(
                          onPressed: () => controller.onFavouriteTap(index),
                          icon: Icon( controller.storyList[index].isFavourite ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                            color:  Colors.redAccent,
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bannerAdsWidget(
      BuildContext context, StoryListController controller) {
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
