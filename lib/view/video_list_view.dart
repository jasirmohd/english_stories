import 'package:english_stories/controller/video_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/common_text_widget.dart';

class VideoListView extends StatefulWidget {
  const VideoListView({super.key});

  @override
  State<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoListController>(
      init: VideoListController(),
        builder:(controller) => SafeArea(child: _contentWidget(context, controller)));
  }

  Widget _contentWidget(BuildContext context, VideoListController controller) {
    return Obx(
        () => ListView.builder(
          itemCount: controller.videoList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _itemWidget(context, index, controller);
          }),
    );
  }

  Widget _itemWidget(BuildContext context, int index, VideoListController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: SizedBox(
        height: 200,
        width: Get.width,
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 160,
                    width: Get.width,
                    color: Colors.black,
                  )),
              Expanded(flex: 0, child: CommonTextWidget(text: controller.videoList[index].title))
            ],
          ),
        ),
      ),
    );
  }
}
