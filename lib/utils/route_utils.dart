import 'package:english_stories/view/bookmark_view.dart';
import 'package:english_stories/view/dictionary_search_view.dart';
import 'package:english_stories/view/dictionary_view.dart';
import 'package:english_stories/view/favourite_view.dart';
import 'package:english_stories/view/main_view.dart';
import 'package:english_stories/view/other_apps_view.dart';
import 'package:english_stories/view/saved_words_view.dart';
import 'package:english_stories/view/splash_view.dart';
import 'package:english_stories/view/story_list_view.dart';
import 'package:english_stories/view/story_view.dart';
import 'package:get/get.dart';

class RouteUtils{

  static const String splashView = '/splash_view';
  static const String mainView = '/main_view';
  static const String storyListView = '/story_list_view';
  static const String storyView = '/story_view';
  static const String dictionaryView = '/dictionary_view';
  static const String dictionarySearchView = '/dictionary_search_view';
  static const String savedWordsView = '/saved_words_view';
  static const String favouriteView = '/favourite_view';
  static const String bookmarkView = '/bookmark_view';
  static const String otherAppsView = '/other_apps_view';


  final pages = [
    GetPage(name: splashView, page: () => const SplashView()),
    GetPage(name: mainView, page: () => const MainView()),
    GetPage(name: storyListView, page: () => const StoryListView()),
    GetPage(name: storyView, page: () => const StoryView()),
    GetPage(name: favouriteView, page: () => const FavouriteView()),
    GetPage(name: bookmarkView, page: () => const BookMarkView()),
    GetPage(name: dictionaryView, page: () => const DictionaryView()),
    GetPage(name: dictionarySearchView, page: () => const DictionarySearchView()),
    GetPage(name: savedWordsView, page: () => const SavedWordsView()),
    GetPage(name: otherAppsView, page: () => const OtherAppsView()),
  ];
}