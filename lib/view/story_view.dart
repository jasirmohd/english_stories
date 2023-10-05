import 'package:english_stories/controller/story_controller.dart';
import 'package:english_stories/resources/app_colors.dart';
import 'package:english_stories/widgets/common_text_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(),
        builder: (controller) => Scaffold(
          appBar: _appBarWidget(context, controller),
        ));
  }

  PreferredSizeWidget _appBarWidget(BuildContext context, StoryController controller){
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back, color: AppColors.black,)),
      title: const CommonTextWidget(text: ''),
      centerTitle: true,
    );
  }
}
