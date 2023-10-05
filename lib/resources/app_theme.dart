import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme{

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteFade,
    brightness: Brightness.light,
    cardColor: AppColors.white,
    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.white
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: AppColors.black,
        fontSize: 20,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackFade,
    brightness: Brightness.dark,
    cardColor: AppColors.black,
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.black
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: AppColors.white,
        fontSize: 20,
      ),
    ),
  );
}