// ignore_for_file: use_build_context_synchronously

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/button/auth_button.dart';
import 'package:adyah_wholesale/components/button/common_button.dart';
import 'package:adyah_wholesale/components/common_text_field/common_text_field.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/authentication/sign_up_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const LoginScreen({super.key, required this.toggleTheme});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool validateEmail = false;
  bool validatePassword = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Image.asset(
          "assets/png/adyah_logo.png",
          height: 100,
          width: 100,
          color: SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor
              : colors.themebluecolor,
        ),
        centerTitle: true,
      ),
      body: loginWidget(pl, context),
    );
  }

  Padding loginWidget(ProgressLoader pl, BuildContext context) {
    return Padding(
      padding: SizerUtil.deviceType == DeviceType.mobile
          ? const EdgeInsets.all(8.0)
          : EdgeInsets.only(left: 4.h, right: 4.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: text("Sign in", fontSize: 15.sp),
              ),
              sizedboxWidget(),
              commonTextformField("Email Address", emailController, (val) {
                final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (val!.isEmpty) {
                  validateEmail = false;
                  return "You must enter a valid email.";
                } else if (!emailRegExp.hasMatch(val)) {
                  return 'Enter a valid email address';
                } else {
                  validateEmail = true;
                }
                return null;
              }, validateEmail, TextInputType.emailAddress, false),
              sizedboxWidget(),
              commonTextformField("Password", passwordController, (val) {
                validatePassword = false;
                if (val!.isEmpty) {
                  return "You must enter a password.";
                } else {
                  validatePassword = true;
                }
                return null;
              }, validatePassword, null, true),
              SizedBox(
                height: 4.h,
              ),
              commonButtonWidget(() async {
                if (_formKey.currentState!.validate()) {
                  await pl.show();
                  await apis.loginUserApi(
                      emailController.text,
                      passwordController.text,
                      pl,
                      context,
                      widget.toggleTheme,
                      setState);
                  await pl.hide();
                }
              }, "Sign in"),
              sizedboxWidget(),
              authenticationTextSpan(
                  context, "Don't have an account?", "Sign Up", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(
                              toggleTheme: widget.toggleTheme,
                            )));
              }),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
