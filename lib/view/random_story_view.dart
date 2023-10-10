import 'package:english_stories/controller/random_story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandomStoryView extends StatelessWidget {
  const RandomStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RandomStoryController(),
        builder: (controller) => SizedBox(
          width: Get.width,
          height: Get.height,
          child: ListView(
            children: [
              Obx(() => Visibility(
                  visible: controller.oneDayStoryVisibility.value,
                  child: _oneDayStoryWidget(context, controller))),
            ],
          ),
        ),);
  }

  Widget _oneDayStoryWidget(BuildContext context, RandomStoryController controller) {
    return InkWell(
      onTap: () => controller.onOneDayStoryTap(),
      child: Card(
        child: SizedBox(
          height: 200,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 160,
                      width: Get.width,
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
}
