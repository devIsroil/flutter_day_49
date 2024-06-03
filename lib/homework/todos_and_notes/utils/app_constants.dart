import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static ThemeMode themeMode = ThemeMode.light;
  static String imageUrl =
      'https://images.unsplash.com/photo-1500828131278-8de6878641b8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bmF0dXJhbHxlbnwwfHwwfHx8MA%3D%3D';
  static String language = 'uz';
  static Color appColor = Colors.white;

  static String password = '0000';
  static Color textColor = Colors.black;
  static double textSize = 14;

  Future<void> setConstants() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String isDark = preferences.getString('isDark') ?? 'false';
    themeMode = isDark == 'true' ? ThemeMode.dark : ThemeMode.light;

    imageUrl = preferences.getString('image') ??
        'https://images.unsplash.com/photo-1500828131278-8de6878641b8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bmF0dXJhbHxlbnwwfHwwfHx8MA%3D%3D';

    language = preferences.getString('language') ?? 'uz';

    int colorValues = preferences.getInt('app-color') ?? 1;
    appColor = colorValues == 1 ? Colors.blue : Color(colorValues);

    password = preferences.getString('password') ?? '0000';

    String box = preferences.getString('text-val') ?? 'null';
    if (box != 'null') {
      final Map<String, dynamic> temp = jsonDecode(box);
      textSize = temp['text-size'];
      textColor = Color(temp['text-color']);
      //textColor = themeMode == ThemeMode.dark ? Colors.white : Color(temp['text-color']);
    }
  }
}