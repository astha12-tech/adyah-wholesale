// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/size_config.dart';
import 'package:adyah_wholesale/firebase_notification/firebase_notificaton.dart';
import 'package:adyah_wholesale/launguage/app_langugage_provider.dart';
import 'package:adyah_wholesale/launguage/app_localizations.dart';
import 'package:adyah_wholesale/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  AppLanguageProvider? appLanguage;
  MyApp({super.key, required this.appLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  void getCollectionData() async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("storehash");

    collectionReference.snapshots().listen((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var storeHashValue = data["storehashh"];
        var accessToken = data["access_token"];
        var clientSecret = data["client_secret"];
        var clientId = data["client_id"];
        var authTokenV3 = data["auth_token_v3_live"];
        var authTokenV2 = data["auth_token_v2_live"];
        debugPrint("***====== storeHashValue ======*** $storeHashValue\n");
        debugPrint("***====== clientSecret ======*** $clientSecret\n");
        debugPrint("***====== clientId ======*** $clientId\n");
        debugPrint("***====== accessToken ======*** $accessToken\n");

        SpUtil.putString(SpConstUtil.storeHashValue, storeHashValue);
        SpUtil.putString(SpConstUtil.accessToken, accessToken);
        SpUtil.putString(SpConstUtil.clientSecret, clientSecret);
        SpUtil.putString(SpConstUtil.clientId, clientId);
        SpUtil.putString(SpConstUtil.authTokenV3, authTokenV3);
        SpUtil.putString(SpConstUtil.authTokenV2, authTokenV2);
      }
    });
  }

  Future<void> _loadThemePreference() async {
    await SpUtil.getInstance();
    final bool? isDarkMode = SpUtil.getBool(SpConstUtil.appTheme);
    if (mounted) {
      setState(() {
        _isDarkMode = isDarkMode ?? false;
      });
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      SpUtil.putBool(SpConstUtil.appTheme, _isDarkMode);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    firebaseNotifications.pushFCMtoken();
    firebaseNotifications.initMessaging();
    getCollectionData();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return ChangeNotifierProvider(
              create: (BuildContext context) => widget.appLanguage,
              builder: (context, child) => Consumer<AppLanguageProvider>(
                  builder: (context, value, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
                  // home: const AddNewCardScreen(),
                  home: SplashScreen(
                      isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
                  locale: value.appLocal,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('ne', 'NP'),
                    Locale('gu', 'IN'),
                  ],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                );
              }),
            );
          });
        },
      ),
    );
  }
}
