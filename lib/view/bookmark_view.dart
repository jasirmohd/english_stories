import 'package:english_stories/controller/bookmark_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({super.key});

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      init: BookmarkController(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _appBarWidget(context),
        body: SafeArea(child: _contentWidget(context, controller)),
      ),
    );
  }

  PreferredSizeWidget _appBarWidget(
      BuildContext context) {
    return AppBar(
      title: Text('Bookmark', style: Theme.of(context).textTheme.titleMedium,),
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


  Widget _contentWidget(BuildContext context, BookmarkController controller) {
    return Obx(
        () => ListView.builder(
          itemCount: controller.bookmarkList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _itemWidget(context, index, controller);
          }),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, BookmarkController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    controller.bookmarkList[index].title.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
