import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale("en");

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return Null;
    }

    _appLocale = Locale(prefs.getString('language_code')!);
    notifyListeners();
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ne")) {
      _appLocale = const Locale("ne");
      await prefs.setString('language_code', 'ne');
      await prefs.setString('countryCode', 'NE');
    } else if (type == const Locale("gu")) {
      _appLocale = const Locale("gu");
      await prefs.setString('language_code', 'gu');
      await prefs.setString('countryCode', 'IN');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
