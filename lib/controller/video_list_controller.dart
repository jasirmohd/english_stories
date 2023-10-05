import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_stories/model/video_response_model.dart';
import 'package:get/get.dart';

class VideoListController extends GetxController{
  static VideoListController get to => Get.put(VideoListController());

  final _db = FirebaseFirestore.instance;

  final videoList = RxList<VideoResponseModel>([]);

  @override
  void onReady() {
    getVideoFromApi();
    super.onReady();
  }

  Future getVideoFromApi() async {
    final snapshot = await _db.collection('videos').get();
    final dataList = snapshot.docs.map((e) => VideoResponseModel.fromSnapshot(e)).toList();
    if(videoList.isNotEmpty){
      videoList.clear();
    }
    videoList.addAll(dataList);
  }
}