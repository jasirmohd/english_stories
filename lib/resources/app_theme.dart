import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[200]!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0))
      )
    ),
    colorScheme: ColorScheme.light(
        background: Colors.grey[300]!,
        primary: Colors.grey[200]!,
        secondary: Colors.grey[300]!),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[200]!,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[300]!,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
    cardTheme: CardTheme(
      color: Colors.grey[200]!,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0)
    )
  );

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
            color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[900]!,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0))
          )
      ),
      colorScheme: ColorScheme.dark(
          background: Colors.black,
          primary: Colors.grey[900]!,
          secondary: Colors.grey[800]!),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900]!,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[800]!,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
      cardTheme: CardTheme(
          color: Colors.grey[900]!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0)
      )
  );
}
