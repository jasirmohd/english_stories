import 'package:english_stories/controller/story_list_controller.dart';
import 'package:english_stories/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/common_text_widget.dart';

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
        appBar: _headContentWidget(context, controller),
        body: _contentWidget(context, controller),
      ),
    );
  }

  PreferredSizeWidget _headContentWidget(
      BuildContext context, StoryListController controller) {
    return AppBar(
      backgroundColor: AppColors.whiteFade,
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      title: CommonTextWidget(text: controller.category.value),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CommonTextWidget(
                      text: controller.storyList[index].title)),
              Expanded(
                  flex: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.black,
                      ))),
              Expanded(
                  flex: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_add_outlined,
                        color: Colors.black,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
