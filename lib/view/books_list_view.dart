import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_stories/controller/book_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../widgets/common_native_ads_widget.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key, required this.theme});

  final bool theme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookListController>(
        init: BookListController(),
        builder: (controller) =>
            SafeArea(child: Column(
              children: [
                Expanded(flex:0,child: _adContentWidget(context, controller)),
                Expanded(flex:1,child: _contentWidget(context, controller)),
              ],
            )));
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
    return Card(
      child: SizedBox(
        // height: 200,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 0,
                  child: CachedNetworkImage(
                    imageUrl: controller.bookList[index].imageUrl,
                    height: 150,
                    width: 110,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.bookList[index].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        controller.bookList[index].description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      RatingBar.builder(
                        initialRating: controller.bookList[index].rating,
                        minRating: controller.bookList[index].rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      OutlinedButton(onPressed: () async => await controller.onBuyNowTap(index), child: Text('Buy Now', style: Theme.of(context).textTheme.titleSmall,), style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color: Theme.of(context).textTheme.titleMedium!.color!,
                          style: BorderStyle.solid,
                        ),
                      ),)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _adContentWidget(
      BuildContext context, BookListController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() => !controller.nativeAdIsLoaded.value
          ? const SizedBox()
          : CommonNativeAdsWidget(isSmall: true,
        nativeAd: controller.nativeAd!,
      )),
    );
  }
}
