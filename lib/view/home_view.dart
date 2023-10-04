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
    return SafeArea(
      child: _contentWidget(context),
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
              Expanded(
                  flex: 0,
                  child: Container(
                    height: 90,
                    width: 70,
                    color: Colors.black,
                  )),
              SizedBox(width: 15,),
              Expanded(flex: 1, child: CommonTextWidget(text: 'test'))
            ],
          ),
        ),
      ),
    );
  }
}
