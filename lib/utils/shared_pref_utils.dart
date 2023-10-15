import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{

  static const String keyReadTimer = 'key_read_timer';
  static const String keyTheme = 'key_theme';
  static const String keyRecentSearchWords = 'key_recent_search_words';
  static const String keyDate = 'key_date';
  static const String keyBodyFontSize = 'key_body_font_size';

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

  set saveDate(String? value)  {
    _prefs?.setString(keyDate, value ?? '');
  }

  String getDate() => _prefs?.getString(keyDate) ?? '';

  set saveFontSize(double? value)  {
    _prefs?.setDouble(keyBodyFontSize, value ?? 14.0);
  }

  double getFontSize() => _prefs?.getDouble(keyBodyFontSize) ?? 14.0;

  set saveRecentWords(List<String>? value)  {
    _prefs?.setStringList(keyRecentSearchWords, value ?? []);
  }

  List<String> getRecentWords() => _prefs?.getStringList(keyRecentSearchWords) ?? [];

}