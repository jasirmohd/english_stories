import 'package:english_stories/controller/dictionary_controller.dart';
import 'package:english_stories/widgets/common_text_field_widget.dart';
import 'package:english_stories/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DictionaryController>(
      init: DictionaryController(),
      builder: (controller) => SafeArea(
          child: Column(
        children: [
          Expanded(flex: 0, child: _headContentWidget(context, controller)),
          Expanded(flex: 1, child: _mainContentWidget(context, controller))
        ],
      )),
    );
  }

  Widget _headContentWidget(
      BuildContext context, DictionaryController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CommonTextWidget(text: 'Dictionary'),
          CommonTextFieldWidget(
              controller: controller.searchWordController,
              fieldType: '',
              padding: 10.0,
              hint: 'Enter a word to search!'),
        ],
      ),
    );
  }

  Widget _mainContentWidget(BuildContext context, DictionaryController controller){
    return SizedBox();
  }
}
