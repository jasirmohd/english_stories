import 'package:english_stories/controller/favourite_controller.dart';
import 'package:english_stories/widgets/common_banner_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
      init: FavouriteController(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _appBarWidget(context),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(flex: 1, child: _contentWidget(context, controller)),
            Expanded(flex: 0, child: _bannerAdsWidget(context, controller))
          ],
        )),
      ),
    );
  }

  PreferredSizeWidget _appBarWidget(BuildContext context) {
    return AppBar(
      title: Text(
        'Favourite',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          weight: 50,
          size: 35,
        ),
      ),
    );
  }

  Widget _contentWidget(BuildContext context, FavouriteController controller) {
    return Obx(
      () => ListView.builder(
          itemCount: controller.favouriteList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _itemWidget(context, index, controller);
          }),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, FavouriteController controller) {
    return Card(
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    controller.favouriteList[index].title.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerAdsWidget(
      BuildContext context, FavouriteController controller) {
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
