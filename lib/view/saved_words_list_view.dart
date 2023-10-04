import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/common_text_widget.dart';

class SavedWordsListView extends StatefulWidget {
  const SavedWordsListView({super.key});

  @override
  State<SavedWordsListView> createState() => _SavedWordsListViewState();
}

class _SavedWordsListViewState extends State<SavedWordsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _contentWidget(context)),
    );
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
        width: Get.width,
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Expanded(flex: 1, child: CommonTextWidget(text: 'test')),
              Expanded(child: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded, color: Colors.black,))),
              Expanded(child: IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined, color: Colors.black,))),
            ],
          ),
        ),
      ),
    );
  }
}
