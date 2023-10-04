import 'package:english_stories/view/bookmark_view.dart';
import 'package:english_stories/view/favourite_view.dart';
import 'package:english_stories/view/main_view.dart';
import 'package:english_stories/view/other_apps_view.dart';
import 'package:english_stories/view/remainder_view.dart';
import 'package:english_stories/view/saved_words_view.dart';
import 'package:english_stories/view/splash_view.dart';
import 'package:english_stories/view/story_list_view.dart';
import 'package:english_stories/view/story_view.dart';
import 'package:english_stories/view/video_view.dart';
import 'package:get/get.dart';

class RouteUtils{

  static const String splashView = '/splash_view';
  static const String mainView = '/main_view';
  static const String storyListView = '/story_list_view';
  static const String storyView = '/story_view';
  static const String videoView = '/video_view';
  static const String favouriteView = '/favourite_view';
  static const String bookmarkView = '/bookmark_view';
  static const String savedWordsView = '/saved_words_view';
  static const String otherAppsView = '/other_apps_view';
  static const String remainderView = '/remainder_view';


  final pages = [
    GetPage(name: splashView, page: () => const SplashView()),
    GetPage(name: mainView, page: () => const MainView()),
    GetPage(name: storyListView, page: () => const StoryListView()),
    GetPage(name: storyView, page: () => const StoryView()),
    GetPage(name: videoView, page: () => const VideoView()),
    GetPage(name: favouriteView, page: () => const FavouriteView()),
    GetPage(name: bookmarkView, page: () => const BookMarkView()),
    GetPage(name: savedWordsView, page: () => const SavedWordsView()),
    GetPage(name: otherAppsView, page: () => const OtherAppsView()),
    GetPage(name: remainderView, page: () => const RemainderView())
  ];
}