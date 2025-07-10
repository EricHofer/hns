import 'package:flutter/material.dart';

class AppColors {
  static Color clrPrimary = const Color.fromRGBO(162, 29, 19, 1);
  static Color clrPrimaryAccent = const Color.fromRGBO(120, 14, 19, 1);
  static Color clrSecondary = const Color.fromARGB(255, 192, 102, 151);
  static Color clrAppBar = const Color.fromRGBO(105, 105, 109, 1);
  static Color clrBackground = const Color.fromRGBO(45, 45, 19, 1);
  static Color clrSecondaryAccent = const Color.fromRGBO(135, 35, 35, 1);
  static Color clrTitle = const Color.fromRGBO(100, 200, 200, 1);
  static Color clrText = Colors.black;
  static Color clrSuccess = const Color.fromRGBO(9, 149, 110, 1);
  static Color clrHighlight = const Color.fromRGBO(212, 172, 19, 1);
}

ThemeData thmPrimary = ThemeData(
  cardTheme: CardThemeData(
    color: AppColors.clrSecondary.withValues(),
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(),
    shadowColor: Colors.transparent,
    margin: const EdgeInsets.only(bottom: 16),
  ),

  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.clrPrimary),

  //Scaffold
  scaffoldBackgroundColor: AppColors.clrSecondaryAccent,

  //AppBr
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.clrSecondary,
    foregroundColor: AppColors.clrAppBar,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  // Text
  // Note alternative is to do textTheme: TextThem().copyWith() which will override #21 4m16
  textTheme: TextTheme(
    //#21 1m40
    bodyMedium: TextStyle(
      color: AppColors.clrText,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.clrTitle,
      fontSize: 16,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: AppColors.clrTitle,
      fontSize: 18,
      letterSpacing: 2,
      fontWeight: FontWeight.bold,
    ),
  ),
);
