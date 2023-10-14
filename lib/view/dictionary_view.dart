import 'package:english_stories/controller/dictionary_controller.dart';
import 'package:english_stories/widgets/common_native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DictionaryController>(
      init: DictionaryController(),
      builder: (controller) =>  SafeArea(
            child: _contentWidget(context, controller)),
    );
  }

  Widget _contentWidget(BuildContext context, DictionaryController controller) {
    return Column(
      children: [
        Text(
          'Dictionary',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45.0),
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .color!))),
              ),
            ),
            Expanded(
              flex:0,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                      size: 35,
                      color: Theme.of(context).textTheme.titleMedium!.color!,
                    )))
          ],
        ),
        Text(
          'Recent Words',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          flex:0,
            child: Obx(() => ListView.separated(
                  itemCount: controller.recentSearchList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _itemWidget(context, index, controller),
                  separatorBuilder: (context, index) => const Divider(
                    height: 2,
                  ),
                ))),
        _nativeAdsWidget(context, controller)
      ],
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, DictionaryController controller) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  controller.recentSearchList[index].title.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                )),
          ],
        ),
      ),
    );
  }

  Widget _nativeAdsWidget(
      BuildContext context, DictionaryController controller) {
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
