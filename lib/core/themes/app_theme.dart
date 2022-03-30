import 'package:flutter/material.dart';
import 'package:riderbuyers/core/themes/palette.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: Palette.kToDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    // Define the default font family.
    fontFamily: 'Railway',
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, color: Colors.black,fontFamily: "Arial narrow"),
      headline5: TextStyle(fontSize: 30.0, color: Colors.black, fontFamily: "Arial narrow"), //In Use
      headline6: TextStyle(fontSize: 36.0, color: Colors.black, fontFamily: "Arial narrow"),
      bodyText2: TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Arial narrow'),
      button: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Arial narrow",),
    ),
    iconTheme: const IconThemeData(color: Palette.kToDark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0.0,toolbarHeight: 0.0),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Palette.kToDark.shade50, ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Palette.kToDark.shade200),),),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Palette.kToDark.shade200),
    popupMenuTheme: PopupMenuThemeData(color: Palette.kToDark.shade200),
    cardTheme: CardTheme(color: Palette.kToDark.shade200),
    sliderTheme: SliderThemeData(activeTickMarkColor: Colors.white,activeTrackColor: Colors.white,disabledInactiveTrackColor: Colors.black,disabledActiveTickMarkColor: Colors.white,thumbColor: Colors.white,inactiveTrackColor: Colors.black),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Palette.kToDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    // Define the default font family.
    fontFamily: 'Railway',
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline5: TextStyle(fontSize: 30.0, color: Colors.white, fontFamily: "'Arial narrow'"), //In Use
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Railway', color: Colors.white),
      button: TextStyle(fontWeight: FontWeight.normal, fontFamily: "Railway",),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0.0,toolbarHeight: 0.0),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white, ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),),),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Palette.kToDark.shade200),
    popupMenuTheme: PopupMenuThemeData(color: Colors.white),
    cardTheme: CardTheme(color: Palette.kToDark),
    sliderTheme: SliderThemeData(activeTickMarkColor: Colors.white,activeTrackColor: Colors.white,disabledInactiveTrackColor: Colors.black,disabledActiveTickMarkColor: Colors.white,thumbColor: Colors.white,inactiveTrackColor: Colors.black),
  );
}
