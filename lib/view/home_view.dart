import 'package:english_stories/controller/home_controller.dart';
import 'package:english_stories/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => SizedBox(
        width: Get.width,
        height: Get.height,
        child: ListView(
          children: [
            Obx(() => Visibility( visible: controller.oneDayStoryVisibility.value,child: _oneDayStoryWidget(context, controller))),
            _contentWidget(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _oneDayStoryWidget(BuildContext context, HomeController controller) {
    return  InkWell(
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
                      child:
                          Text(controller.oneDayTitle.value, style: Theme.of(context).textTheme.titleSmall,))
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _contentWidget(BuildContext context, HomeController controller) {
    return SizedBox(
      child: Obx(
        () => ListView.builder(
            itemCount: controller.storyCategoryList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _itemWidget(context, index, controller);
            }),
      ),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, HomeController controller) {
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
                    flex: 0,
                    child: Container(
                      height: 90,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(image: AssetImage(controller.storyCategoryList[index].image))
                      ),
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      controller.storyCategoryList[index].category,
                      style: Theme.of(context).textTheme.titleMedium,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
