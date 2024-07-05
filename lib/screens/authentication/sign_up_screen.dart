// ignore_for_file: use_build_context_synchronously

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/button/auth_button.dart';
import 'package:adyah_wholesale/components/button/common_button.dart';
import 'package:adyah_wholesale/components/common_text_field/common_text_field.dart';
import 'package:adyah_wholesale/components/country_picker_widget.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/authentication/login_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const SignUpScreen({super.key, required this.toggleTheme});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  bool validateEmail = false;
  bool validatePassword = false;
  bool validateConfirmPassword = false;
  bool validateCompanyName = false;
  bool validateFirstName = false;
  bool validateLastName = false;
  bool validatePhoneNo = false;
  bool validateAddressLine1 = false;
  bool validateAddressLine2 = false;
  bool validateCity = false;
  bool validateState = false;
  bool validateZipCode = false;

  String? countryCode;
  String? countryName;
  void _updateCountry(String? code, String? name) {
    setState(() {
      countryCode = code;
      countryName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
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
      body: signUpScreen(context, pl),
    );
  }

  Padding signUpScreen(BuildContext context, ProgressLoader pl) {
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
                child: text("New Account", fontSize: 15.sp),
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
              sizedboxWidget(),
              commonTextformField("Confirm Password", confirmpasswordController,
                  (val) {
                validatePassword = false;
                if (val!.isEmpty) {
                  return "You must enter a password.";
                } else {
                  validateConfirmPassword = true;
                }
                return null;
              }, validateConfirmPassword, null, true),
              sizedboxWidget(),
              commonTextformField("Company Name", companyNameController, null,
                  validateCompanyName, null, false),
              sizedboxWidget(),
              commonTextformField("First Name", firstNameController, (val) {
                validateFirstName = false;
                if (val!.isEmpty) {
                  return "First Name field cannot be blank.";
                } else {
                  validateFirstName = true;
                }
                return null;
              }, validateFirstName, null, false),
              sizedboxWidget(),
              commonTextformField("Last Name", lastNameController, (val) {
                validateLastName = false;
                if (val!.isEmpty) {
                  return "Last Name field cannot be blank.";
                } else {
                  validateLastName = true;
                }
                return null;
              }, validateLastName, null, false),
              sizedboxWidget(),
              commonTextformField("Phone Number", phoneNoController, null,
                  validatePhoneNo, TextInputType.phone, false),
              sizedboxWidget(),
              commonTextformField("Address Line 1", addressLine1Controller,
                  (val) {
                validateAddressLine1 = false;
                if (val!.isEmpty) {
                  return "Address Line 1 field cannot be blank.";
                } else {
                  validateAddressLine1 = true;
                }
                return null;
              }, validateAddressLine1, null, false),
              sizedboxWidget(),
              commonTextformField("Address Line 2", addressLine2Controller,
                  null, validateAddressLine2, null, false),
              sizedboxWidget(),
              commonTextformField("Suburb/City", cityController, (val) {
                validateCity = false;
                if (val!.isEmpty) {
                  return "Suburb/City field cannot be blank.";
                } else {
                  validateCity = true;
                }
                return null;
              }, validateCity, null, false),
              sizedboxWidget(),
              countryPickerWidget(
                  context, _updateCountry, countryCode, countryName),
              sizedboxWidget(),
              commonTextformField("State/Province", stateController, (val) {
                validateState = false;
                if (val!.isEmpty) {
                  return "State/Province field cannot be blank.";
                } else {
                  validateState = true;
                }
                return null;
              }, validateState, null, false),
              sizedboxWidget(),
              commonTextformField("Zip/Postcode", zipCodeController, (val) {
                validateZipCode = false;
                if (val!.isEmpty) {
                  return "Zip/Postcode field cannot be blank.";
                } else {
                  validateZipCode = true;
                }
                return null;
              }, validateZipCode, TextInputType.number, false),
              SizedBox(
                height: 4.h,
              ),
              commonButtonWidget(() async {
                if (_formKey.currentState!.validate()) {
                  if (countryCode != null) {
                    await pl.show();
                    await apis.createUserApi(
                        emailController.text,
                        firstNameController.text,
                        lastNameController.text,
                        companyNameController.text,
                        phoneNoController.text,
                        addressLine1Controller.text,
                        addressLine2Controller.text,
                        cityController.text,
                        passwordController.text,
                        zipCodeController.text,
                        stateController.text,
                        countryCode!,
                        pl,
                        context,
                        widget.toggleTheme);
                    await pl.hide();
                  } else {
                    apis.showToast("Country field cannot be blank.");
                  }
                }
              }, "Create Account"),
              SizedBox(
                height: 2.h,
              ),
              authenticationTextSpan(
                  context, "Already have an account?", "Login", () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      toggleTheme: widget.toggleTheme,
                    ),
                  ),
                  (route) => false,
                );
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
