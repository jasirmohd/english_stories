import 'package:english_stories/utils/route_utils.dart';
import 'package:english_stories/view/books_list_view.dart';
import 'package:english_stories/view/random_story_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_colors.dart';
import '../resources/app_strings.dart';
import '../view/home_view.dart';

import '../controller/main_controller.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) => Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              key: controller.scaffoldState,
              drawer: _sideDrawerWidget(context, controller),
              appBar: _appBarWidget(context, controller),
              body: _contentWidget(context, controller),
              bottomNavigationBar: _bottomNavBarWidget(context, controller),
            ));
  }

  Widget _sideDrawerWidget(BuildContext context, MainController controller) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
              flex: 0,
              child: Container(
                height: 150,
                width: Get.width,
                color: Colors.black,
              )),
          Expanded(flex:1,child: ListView(
            children: [
              // _sideDrawerItemWidget(context, AppStrings.oneDayStory),
              _sideDrawerItemWidget(context, AppStrings.favourites, RouteUtils.favouriteView),
              _sideDrawerItemWidget(context, AppStrings.bookmarks,RouteUtils.bookmarkView),
              // _sideDrawerItemWidget(context, AppStrings.savedWords),
              const Divider(
                color: AppColors.black,
              ),
              // _sideDrawerItemWidget(context, 'Remainder',''),
              // _sideDrawerItemWidget(context, AppStrings.settings,''),
              _sideDrawerItemWidget(context, AppStrings.otherApps,''),
              _sideDrawerItemWidget(context, AppStrings.rating,''),
              _sideDrawerItemWidget(context, AppStrings.about,''),
              _sideDrawerItemWidget(context, AppStrings.share,''),
              // Expanded(
              //     flex: 1,
              //     child: SizedBox(
              //       width: Get.width,
              //       child: Align(
              //         alignment: Alignment.bottomRight,
              //         child: InkWell(
              //           onTap: () => controller.scaffoldState.currentState?.openEndDrawer(),
              //           radius: 45.0,
              //           borderRadius: BorderRadius.circular(45.0),
              //           child: Card(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(45.0),
              //               ),
              //               child: const Icon(
              //                 Icons.navigate_before_rounded,
              //                 color: AppColors.black,
              //                 weight: 50,
              //                 size: 35,
              //               )),
              //         ),
              //       ),
              //     )),
            ],
          ))

        ],
      ),
    );
  }

  Widget _sideDrawerItemWidget(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        width: Get.width,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarWidget(
      BuildContext context, MainController controller) {
    return AppBar(
      title: Text(AppStrings.appName, style: Theme.of(context).textTheme.titleMedium,),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => controller.scaffoldState.currentState?.openDrawer(),
        icon: const Icon(
          Icons.menu_rounded,
          weight: 50,
          size: 35,
        ),
      ),
      actions: [
        Obx(
          () => IconButton(
              onPressed: controller.onThemeIconTap,
              icon: Icon(
                controller.isLight.value
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                size: 25,
              )),
        ),
        // IconButton(
        //     onPressed: () {
        //       // Schedule the daily notification when the app starts
        //     },
        //     icon: const Icon(
        //       Icons.notifications_none_rounded,
        //       size: 25,
        //     ))
      ],
    );
  }

  Widget _contentWidget(BuildContext context, MainController controller) {
    return IndexedStack(
      index: controller.currentIndex,
      children: const [HomeView(), RandomStoryView(), BooksListView()],
    );
  }

  Widget _bottomNavBarWidget(BuildContext context, MainController controller) {
    return BottomNavigationBar(
        selectedFontSize: 8.0,
        unselectedFontSize: 8.0,
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
                Icons.menu_book_rounded,
              ),
              label: 'Books'),
        ]);
  }
}
