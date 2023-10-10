import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/one_day_story_response_model.dart';
import '../model/story_category_model.dart';
import '../utils/route_utils.dart';

class RandomStoryController extends GetxController{
  static RandomStoryController get to => Get.put(RandomStoryController());

  final _db = FirebaseFirestore.instance;

  final storyCategoryList = RxList<StoryCategoryData>([]);

  final oneDayTitle = ''.obs;
  final onDayImage = ''.obs;
  final onDayCategory = ''.obs;
  final onDayBody = ''.obs;

  final oneDayStoryVisibility = RxBool(false);

  @override
  void onInit() {
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getOneDayStoryFromApi(currentDate);
    super.onInit();
  }

  Future getOneDayStoryFromApi(String date) async {
    final snapshot = await _db.collection('one_day_story').where("date", isEqualTo: date).get();
    final oneDayStoryData = snapshot.docs.map((e) => OneDayStoryResponseModel.fromSnapshot(e));
    if(oneDayStoryData.isNotEmpty) {
      oneDayStoryVisibility.value = true;
      oneDayTitle.value = oneDayStoryData.single.title;
      onDayImage.value = oneDayStoryData.single.imageUrl;
      onDayBody.value = oneDayStoryData.single.body;
      onDayCategory.value = oneDayStoryData.single.category;
    }else{
      oneDayStoryVisibility.value = false;
    }
  }

  onOneDayStoryTap(){
    Get.toNamed(RouteUtils.storyView, arguments: {
      "category":onDayCategory.value,
      "title":oneDayTitle.value,
      "body":onDayBody.value,
      "image_url":onDayImage.value
    });
  }
}