import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/launguage/app_langugage_provider.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LaunguageScreen extends StatefulWidget {
  const LaunguageScreen({super.key});

  @override
  State<LaunguageScreen> createState() => _LaunguageScreenState();
}

class _LaunguageScreenState extends State<LaunguageScreen> {
  List launguagesList = [
    {'key': 'en', 'name': 'English'},
    {'key': 'ne', 'name': 'Hindi'},
    {'key': 'gu', 'name': 'Gujarati'},
  ];
  late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    debugPrint("== appLanguage ==>${appLanguage.appLocal}");
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 4.h,
            width: 4.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.45.h),
              child: Image.asset(
                "assets/png/left.png",
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor
                    : colors.blackcolor,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 18,
        centerTitle: true,
        title: text("Languages",
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15),
            child: text("All Languages",
                fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          for (int i = 0; i < launguagesList.length; i++)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  appLanguage.changeLanguage(Locale(launguagesList[i]['key']));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: colors.blackcolor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.themebluecolor),
                              color: colors.whitecolor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              "assets/png/finish.png",
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        text(launguagesList[i]['name'],
                            color: colors.whitecolor, fontSize: 17),
                        const Spacer(),
                        if (launguagesList[i]['key'].toString() ==
                            appLanguage.appLocal.toString())
                          Icon(
                            Icons.check,
                            color: colors.whitecolor,
                          ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
