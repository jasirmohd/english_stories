import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_stories/controller/book_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    return Obx(
        () => ListView.builder(
          itemCount: controller.bookList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _itemWidget(context, index, controller);
          }),
    );
  }

  Widget _itemWidget(
      BuildContext context, int index, BookListController controller) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: SizedBox(
          height: 200,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    flex: 0,
                    child: CachedNetworkImage(imageUrl: controller.bookList[index].imageUrl,
                      width: 110,fit: BoxFit.fill,)),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.bookList[index].title,style: Theme.of(context).textTheme.titleMedium,),
                        const SizedBox(height: 5,),
                        Text(controller.bookList[index].description,style: Theme.of(context).textTheme.bodySmall,),
                        const SizedBox(height: 5,),
                        RatingBar.builder(
                      initialRating: controller.bookList[index].rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
