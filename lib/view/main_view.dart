import 'package:english_stories/resources/app_colors.dart';
import 'package:english_stories/resources/app_strings.dart';
import 'package:english_stories/view/dictionary_view.dart';
import 'package:english_stories/view/home_view.dart';
import 'package:english_stories/view/video_list_view.dart';
import 'package:english_stories/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>{

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) => Scaffold(
          key: controller.scaffoldState,
              drawer: _sideDrawerWidget(context, controller),
              appBar: _appBarWidget(context, controller),
              body: _contentWidget(context, controller),
              bottomNavigationBar: _bottomNavBarWidget(context, controller),
            ));
  }

  Widget _sideDrawerWidget(BuildContext context, MainController controller) {
    return Drawer(
      child: Container(
        width: Get.width / 1.5,
        height: Get.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            color: AppColors.white),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: Get.width,
                )),
            _sideDrawerItemWidget(context, AppStrings.oneDayStory),
            _sideDrawerItemWidget(context, AppStrings.favourites),
            _sideDrawerItemWidget(context, AppStrings.bookmarks),
            _sideDrawerItemWidget(context, AppStrings.savedWords),
            const Divider(
              color: AppColors.black,
            ),
            _sideDrawerItemWidget(context, AppStrings.settings),
            _sideDrawerItemWidget(context, AppStrings.otherApps),
            _sideDrawerItemWidget(context, AppStrings.rating),
            _sideDrawerItemWidget(context, AppStrings.about),
            _sideDrawerItemWidget(context, AppStrings.share),
            Expanded(
                flex: 0,
                child: SizedBox(
                  width: Get.width,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => controller.scaffoldState.currentState?.openEndDrawer(),
                      radius: 45.0,
                      borderRadius: BorderRadius.circular(45.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          child: const Icon(
                            Icons.navigate_before_rounded,
                            color: AppColors.black,
                            weight: 50,
                            size: 35,
                          )),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _sideDrawerItemWidget(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      width: Get.width,
      height: 50,
      alignment: Alignment.center,
      child: CommonTextWidget(
        text: text,
        textColor: AppColors.black,
      ),
    );
  }

  PreferredSizeWidget _appBarWidget(BuildContext context,MainController controller) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: const CommonTextWidget(text: AppStrings.appName),
      centerTitle: true,
      leading: InkWell(
        onTap: () => controller.scaffoldState.currentState?.openDrawer(),
        radius: 45.0,
        borderRadius: BorderRadius.circular(45.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.0),
            ),
            child: const Icon(
              Icons.navigate_next_rounded,
              color: AppColors.black,
              weight: 50,
              size: 35,
            )),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: 25,
            ))
      ],
    );
  }

  Widget _contentWidget(BuildContext context, MainController controller) {
    return IndexedStack(
      index: controller.currentIndex,
      children: const [HomeView(), VideoListView(), DictionaryView()],
    );
  }

  Widget _bottomNavBarWidget(BuildContext context, MainController controller) {
    return BottomNavigationBar(
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.whiteFade,
        selectedFontSize: 6.0,
        unselectedFontSize: 6.0,
        currentIndex: controller.currentIndex,
        showUnselectedLabels: false,
        onTap: controller.onItemTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'Stories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.video_library_rounded,
              ),
              label: 'Videos'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.spellcheck_rounded,
              ),
              label: 'Dictionary'),
        ]);
  }
}
