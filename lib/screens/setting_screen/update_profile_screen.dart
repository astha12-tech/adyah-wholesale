// ignore_for_file: must_be_immutable, avoid_print

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/common_text_field/common_text_field.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/get_customer_model.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UpdateProfileScreen extends StatefulWidget {
  GetCustomerModel getCustomerModel;
  UpdateProfileScreen({super.key, required this.getCustomerModel});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
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
  final _formKey = GlobalKey<FormState>();
  bool editMode = false;
  @override
  void initState() {
    emailController.text = widget.getCustomerModel.data![0].email!;
    companyNameController.text =
        widget.getCustomerModel.data![0].addresses![0].company!;
    firstNameController.text =
        widget.getCustomerModel.data![0].addresses![0].firstName!;
    lastNameController.text =
        widget.getCustomerModel.data![0].addresses![0].lastName!;
    phoneNoController.text =
        widget.getCustomerModel.data![0].addresses![0].phone!;
    addressLine1Controller.text =
        widget.getCustomerModel.data![0].addresses![0].address1!;
    addressLine2Controller.text =
        widget.getCustomerModel.data![0].addresses![0].address2!;
    cityController.text = widget.getCustomerModel.data![0].addresses![0].city!;
    stateController.text =
        widget.getCustomerModel.data![0].addresses![0].stateOrProvince!;
    zipCodeController.text =
        widget.getCustomerModel.data![0].addresses![0].postalCode!;
    countryCode = widget.getCustomerModel.data![0].addresses![0].countryCode!;
    countryName = widget.getCustomerModel.data![0].addresses![0].country!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    debugPrint(
        "===  widget.getCustomerModel.data![0].company! ====>${widget.getCustomerModel.data![0].company!}");

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
              padding: EdgeInsets.all(0.7.h),
              child: Image.asset(
                "assets/png/back.png",
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
        title: text("Update Profile",
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      sizedboxWidget(),
                      commonTextformField("Email Address", emailController,
                          (val) {
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (val!.isEmpty) {
                          validateEmail = false;
                          return "You must enter a valid email.";
                        } else if (!emailRegExp.hasMatch(val)) {
                          return 'Enter a valid email address';
                        } else {
                          validateEmail = true;
                        }
                        return null;
                      }, validateEmail, TextInputType.emailAddress, false,
                          editMode: editMode),
                      sizedboxWidget(),
                      commonTextformField("Company Name", companyNameController,
                          null, validateCompanyName, null, false,
                          editMode: editMode),
                      sizedboxWidget(),
                      // commonTextformField("First Name", firstNameController,
                      //     (val) {
                      //   validateFirstName = false;
                      //   if (val!.isEmpty) {
                      //     return "First Name field cannot be blank.";
                      //   } else {
                      //     validateFirstName = true;
                      //   }
                      //   return null;
                      // }, validateFirstName, null, false, editMode: editMode),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // commonTextformField("Last Name", lastNameController,
                      //     (val) {
                      //   validateLastName = false;
                      //   if (val!.isEmpty) {
                      //     return "Last Name field cannot be blank.";
                      //   } else {
                      //     validateLastName = true;
                      //   }
                      //   return null;
                      // }, validateLastName, null, false, editMode: editMode),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      commonTextformField("Phone Number", phoneNoController,
                          (val) {
                        validatePhoneNo = false;
                        if (val!.isEmpty) {
                          return "Phone Number cannot be blank.";
                        } else {
                          validatePhoneNo = true;
                        }
                        return null;
                      }, validatePhoneNo, TextInputType.phone, false,
                          editMode: editMode),
                      sizedboxWidget(),
                      commonTextformField(
                          "Address Line 1", addressLine1Controller, (val) {
                        validateAddressLine1 = false;
                        if (val!.isEmpty) {
                          return "Address Line 1 field cannot be blank.";
                        } else {
                          validateAddressLine1 = true;
                        }
                        return null;
                      }, validateAddressLine1, null, false, editMode: editMode),
                      sizedboxWidget(),
                      commonTextformField(
                          "Address Line 2",
                          addressLine2Controller,
                          null,
                          validateAddressLine2,
                          null,
                          false,
                          editMode: editMode),
                      sizedboxWidget(),
                      commonTextformField("Suburb/City", cityController, (val) {
                        validateCity = false;
                        if (val!.isEmpty) {
                          return "Suburb/City field cannot be blank.";
                        } else {
                          validateCity = true;
                        }
                        return null;
                      }, validateCity, null, false, editMode: editMode),
                      sizedboxWidget(),
                      countryPickerWidget(context, editMode),
                      sizedboxWidget(),
                      commonTextformField("State/Province", stateController,
                          (val) {
                        validateState = false;
                        if (val!.isEmpty) {
                          return "State/Province field cannot be blank.";
                        } else {
                          validateState = true;
                        }
                        return null;
                      }, validateState, null, false, editMode: editMode),
                      sizedboxWidget(),
                      commonTextformField("Zip/Postcode", zipCodeController,
                          (val) {
                        validateZipCode = false;
                        if (val!.isEmpty) {
                          return "Zip/Postcode field cannot be blank.";
                        } else {
                          validateZipCode = true;
                        }
                        return null;
                      }, validateZipCode, TextInputType.number, false,
                          editMode: editMode),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 3.h, right: 3.h),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () async {
                        await pl.show();
                        setState(() {
                          editMode = !editMode;
                        });
                        await pl.hide();
                      },
                      child: Container(
                        height: 5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: SpUtil.getBool(SpConstUtil.appTheme)!
                                    ? colors.whitecolor
                                    : colors.themebluecolor),
                            borderRadius: BorderRadius.circular(2.h)),
                        child: Align(
                            alignment: Alignment.center,
                            child: text("Edit",
                                color: SpUtil.getBool(SpConstUtil.appTheme)!
                                    ? colors.whitecolor
                                    : colors.themebluecolor,
                                fontSize: 11.sp)),
                      ),
                    )),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (editMode) {
                            await pl.show();
                            // await apis.updateCustomerApi(
                            //     pl, emailController.text);
                            await apis.updateCustomerApi2(
                                pl,
                                firstNameController.text,
                                lastNameController.text,
                                companyNameController.text,
                                addressLine1Controller.text,
                                addressLine2Controller.text,
                                cityController.text,
                                stateController.text,
                                zipCodeController.text,
                                countryName!,
                                phoneNoController.text,
                                emailController.text);
                            // await apis.updateCustomerAddressApi(
                            //   pl,
                            //   firstNameController.text,
                            //   lastNameController.text,
                            //   companyNameController.text,
                            //   addressLine1Controller.text,
                            //   addressLine2Controller.text,
                            //   cityController.text,
                            //   stateController.text,
                            //   zipCodeController.text,
                            //   countryName!,
                            //   phoneNoController.text,
                            // );

                            await SpUtil.putString(SpConstUtil.firstName,
                                firstNameController.text);
                            await SpUtil.putString(
                                SpConstUtil.lastName, lastNameController.text);
                            await SpUtil.putString(
                                SpConstUtil.userEmail, emailController.text);
                            editMode = false;
                            setState(() {});

                            await pl.hide();
                          } else {
                            debugPrint("====== you'nt editiable ======");
                          }
                        }
                      },
                      child: Container(
                        height: 5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: SpUtil.getBool(SpConstUtil.appTheme)!
                                ? colors.whitecolor
                                : colors.themebluecolor,
                            borderRadius: BorderRadius.circular(2.h)),
                        child: Align(
                            alignment: Alignment.center,
                            child: text("Update Account",
                                color: SpUtil.getBool(SpConstUtil.appTheme)!
                                    ? colors.blackcolor
                                    : colors.whitecolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp)),
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector countryPickerWidget(BuildContext context, bool editMode) {
    return GestureDetector(
      onTap: editMode
          ? () {
              showCountryPicker(
                context: context,
                showPhoneCode:
                    true, // optional. Shows phone code before the country name.
                onSelect: (Country country) {
                  setState(() {
                    countryCode = country.countryCode;
                    debugPrint("displayName==== ${country.displayName}");
                    countryName = country.displayName.split('(')[0].trim();
                  });
                },
              );
            }
          : null,
      child: Container(
        height: 7.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.h),
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor.withOpacity(0.1)
                : colors.themebluecolor.withOpacity(0.1)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            child: Row(
              children: [
                Text(
                  countryName != null ? countryName! : "Choose a Country",
                  style: TextStyle(
                      color: !editMode
                          ? SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor.withOpacity(0.4)
                              : colors.blackcolor.withOpacity(0.4)
                          : countryName != null
                              ? SpUtil.getBool(SpConstUtil.appTheme)!
                                  ? colors.whitecolor
                                  : colors.blackcolor
                              : colors.blackcolor.withOpacity(0.6),
                      fontWeight: !editMode
                          ? fontWeight.normal
                          : countryName != null
                              ? FontWeight.bold
                              : FontWeight.normal,
                      fontSize: 11.sp,
                      fontFamily: "OpenSans"),
                ),
                const Spacer(),
                Image.asset(
                  "assets/png/down_arrow.png",
                  height: 3.h,
                  width: 3.h,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? !editMode
                          ? colors.whitecolor.withOpacity(0.4)
                          : colors.whitecolor
                      : !editMode
                          ? colors.blackcolor.withOpacity(0.4)
                          : colors.blackcolor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
