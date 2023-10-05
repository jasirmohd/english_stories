import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{

  static const String keyFavouriteList = 'key_favourite_list';
  static const String keyHistoryList = 'key_history_list';
  static const String keyReadTimer = 'key_read_timer';
  static const String keyTheme = 'key_theme';

  static SharedPreferences? _prefs;

  factory SharedPrefUtils() => SharedPrefUtils._internal();

  SharedPrefUtils._internal();

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  set saveThemeStatus(bool? value)  {
    _prefs?.setBool(keyTheme, value ?? false);
  }

  bool getThemeStatus() => _prefs?.getBool(keyTheme) ?? false;

}