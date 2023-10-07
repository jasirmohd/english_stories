import 'package:get/get.dart';
import 'package:darq/darq.dart';

import '../model/story_db_model.dart';
import '../repository/story_repository.dart';

class BookmarkController extends GetxController{
  static BookmarkController get to => Get.put(BookmarkController());

  final _repo = StoryRepository();

  final bookmarkList = RxList<StoryDBModel>([]);

  final noData = RxString('');


  @override
  void onInit() {
    loadHistory();
    super.onInit();
  }

  loadHistory() async {
    List<StoryDBModel> dataList = await _repo.getAllBookmarkStory();
    bookmarkList.addAll(dataList.distinct((e) => e.category!));
    bookmarkList.refresh();
    if(bookmarkList.isEmpty){
      noData.value = 'No Favourite stories';
    }
  }
}