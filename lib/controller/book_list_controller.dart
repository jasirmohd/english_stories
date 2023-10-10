import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_stories/model/books_response_model.dart';
import 'package:get/get.dart';

class BookListController extends GetxController{
  static BookListController get to => Get.put(BookListController());

  final _db = FirebaseFirestore.instance;

  final bookList = RxList<BookResponseModel>([]);

  final bookListVisibility = RxBool(false);

  @override
  void onInit() {
    getBookListFromApi();
    super.onInit();
  }

  Future getBookListFromApi() async {
    final snapshot = await _db.collection('books').get();
    final bookDataList = snapshot.docs.map((e) => BookResponseModel.fromSnapshot(e)).toList();
    if(bookDataList.isNotEmpty) {
      bookListVisibility.value = true;
      if(bookList.isNotEmpty){
        bookList.clear();
      }
      bookList.addAll(bookDataList);
    }else{
      bookListVisibility.value = false;
    }
  }
}