// ignore_for_file: avoid_print

import 'dart:async';

import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/screens/authentication/login_screen.dart';
import 'package:adyah_wholesale/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const SplashScreen(
      {super.key,required this.toggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      SpUtil.getInt(SpConstUtil.customerID) == null ||
              SpUtil.getInt(SpConstUtil.customerID) == 0
          ? await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  toggleTheme: widget.toggleTheme,
                ),
              ),
            )
          : await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen(
                  toggleTheme: widget.toggleTheme,
                ),
              ),
            );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/png/adyah_logo.png"),
      ),
    );
  }
}
