import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/launguage/app_langugage_provider.dart';
import 'package:adyah_wholesale/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SpUtil.getInstance();
  await SharedPreferences.getInstance();
  // await SpUtil.clear();
  AppLanguageProvider appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();

  runApp(DevicePreview(
      builder: (context) => const MyApp(
          // appLanguage: appLanguage,
          )));
}
