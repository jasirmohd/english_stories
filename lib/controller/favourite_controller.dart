import 'package:get/get.dart';
import 'package:darq/darq.dart';

import '../model/story_db_model.dart';
import '../repository/story_repository.dart';

class FavouriteController extends GetxController{
  static FavouriteController get to => Get.put(FavouriteController());

  final _repo = StoryRepository();

  final favouriteList = RxList<StoryDBModel>([]);

  final noData = RxString('');


  @override
  void onInit() {
    loadHistory();
    super.onInit();
  }

  loadHistory() async {
    List<StoryDBModel> dataList = await _repo.getAllFavouriteStory();
    favouriteList.addAll(dataList.distinct((e) => e.category!));
    favouriteList.refresh();
    if(favouriteList.isEmpty){
      noData.value = 'No Favourite stories';
    }
  }
}