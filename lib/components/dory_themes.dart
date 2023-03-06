import 'dory_colors.dart';
import 'package:flutter/material.dart';

class DoryThemes {
  static ThemeData get lightTheme => ThemeData(
      fontFamily: 'GmarketSansTTF',
      primarySwatch: DoryColors.primaryMeterialColor,
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.white, // 버튼 클릭했을때 반영되는 색상
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      brightness: Brightness.light);

  static ThemeData get darkTheme => ThemeData(
      fontFamily: 'GmarketSansTTF',
      primarySwatch: DoryColors.primaryMeterialColor,
      splashColor: Colors.white, // 버튼 클릭했을때 반영되는 색상
      textTheme: _textTheme,
      brightness: Brightness.dark);

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: DoryColors.primaryColor),
    elevation: 0,
  );

  // TextTheme용 객체
  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
  );
}
