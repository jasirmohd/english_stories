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
    return SafeArea(child: _contentWidget(context));
  }

  Widget _contentWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _itemWidget(context, index);
        });
  }

  Widget _itemWidget(BuildContext context, int index) {
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
              const Expanded(flex: 0, child: CommonTextWidget(text: 'test'))
            ],
          ),
        ),
      ),
    );
  }
}
