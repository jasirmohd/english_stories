import 'package:english_stories/controller/book_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookListController>(
        init: BookListController(),
        builder: (controller) =>
            SafeArea(child: _contentWidget(context, controller)));
  }

  Widget _contentWidget(BuildContext context, BookListController controller) {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _itemWidget(context, index, controller);
        });
  }

  Widget _itemWidget(
      BuildContext context, int index, BookListController controller) {
    return Card(
      child: SizedBox(
        height: 200,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    height: 150,
                    width: 110,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('test book'),
                      Text('test book'),
                      Text('test book'),
                      Text('test book'),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
