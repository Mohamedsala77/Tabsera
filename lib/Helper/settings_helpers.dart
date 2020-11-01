import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsHelpers {

  SharedPreferences prefs;

  static final SettingsHelpers instance = SettingsHelpers._internal();
  SettingsHelpers._internal(){
  }

  factory SettingsHelpers() => instance;





  static const double minFontSizeArabic = 20;

  double get getFontSizeArabic {
    String fontSizeString = prefs.getString('fontSizeArabic');
    return double.tryParse(fontSizeString ?? minFontSizeArabic.toString());
  }

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
