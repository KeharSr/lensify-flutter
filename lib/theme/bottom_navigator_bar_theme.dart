import 'package:flutter/material.dart';

class KBottomNavigatorBarTheme {
  KBottomNavigatorBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavigatorBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: Colors.blue),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );

  static BottomNavigationBarThemeData darkBottomNavigatorBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: Colors.blue),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
}
