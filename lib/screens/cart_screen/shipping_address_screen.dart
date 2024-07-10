// ignore_for_file: must_be_immutable, unused_element, use_build_context_synchronously

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/billing_checkout_model.dart';
import 'package:adyah_wholesale/model/checkout_consignments_update_model.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShippingAddressScreen extends StatefulWidget {
  CheckoutConsignmentsUpdateModel checkoutModel;
  void Function() toggleTheme;

  ShippingAddressScreen(
      {super.key, required this.checkoutModel, required this.toggleTheme});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  bool validateCompanyName = false;
  bool validateLastName = false;
  bool validateEmail = false;
  bool validateAddressLine2 = false;
  bool validateFirstName = false;
  bool validateAddressLine1 = false;
  bool validateCity = false;
  bool validatePhoneNo = false;
  bool validateState = false;
  bool validateZipCode = false;

  String? countryCode;
  String? countryName;
  String? _selectedShippingMethod;
  void _updateCountry(String? code, String? name) {
    setState(() {
      countryCode = code;
      countryName = name;
    });
  }

  // List<ShippingMethod> shippingMethodList = [
  //   ShippingMethod("Pickup In Store", "pickup"),
  //   ShippingMethod("Delivery", "delivery"),
  //   ShippingMethod("Fedex/UPS", "fedex"),
  // ];
  @override
  void initState() {
    if (widget.checkoutModel.data!.consignments!.isNotEmpty) {
      companyNameController.text =
          widget.checkoutModel.data!.consignments![0].shippingAddress!.company!;
      firstNameController.text = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.firstName!;
      lastNameController.text = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.lastName!;
      addressLine1Controller.text = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.address1!;
      addressLine2Controller.text = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.address2!;
      countryCode = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.countryCode!;
      countryName =
          widget.checkoutModel.data!.consignments![0].shippingAddress!.country!;
      stateController.text = widget.checkoutModel.data!.consignments![0]
          .shippingAddress!.stateOrProvince!;
      cityController.text =
          widget.checkoutModel.data!.consignments![0].shippingAddress!.city!;
      zipCodeController.text = widget
          .checkoutModel.data!.consignments![0].shippingAddress!.postalCode!;
      phoneNoController.text =
          widget.checkoutModel.data!.consignments![0].shippingAddress!.phone!;
      _selectedShippingMethod = widget.checkoutModel.data!.consignments![0]
          .selectedShippingOption!.description!;
    }
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    companyNameController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    addressLine2Controller.dispose();
    addressLine1Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    debugPrint(
        "=== consignments ==>${widget.checkoutModel.data!.consignments}");
    debugPrint(
        "=== consignments ==>${widget.checkoutModel.data!.consignments![0].selectedShippingOption}");
    debugPrint(
        "=== billingAddress!.firstName ==>${widget.checkoutModel.data!.billingAddress!.firstName}");

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
                child: Image.asset("assets/png/left.png",
                    color: SpUtil.getBool(SpConstUtil.appTheme)!
                        ? colors.whitecolor
                        : colors.blackcolor),
              ),
            ),
          ),
          scrolledUnderElevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height / 18,
          automaticallyImplyLeading: false,
          centerTitle: true,
          // backgroundColor: colors.themebluecolor,
          title: text("Confirm Order",
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: SpUtil.getBool(SpConstUtil.appTheme)!
                  ? colors.whitecolor
                  : colors.blackcolor),
        ),
        body: shippingAddressWidget(pl));
  }

  Widget shippingAddressWidget(ProgressLoader pl) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(1.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Shipping & Billing Address",
                  fontSize: 12.sp, fontWeight: FontWeight.bold),
              SizedBox(
                height: 1.h,
              ),

              Card(
                elevation: 3,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(0.2.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Company :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.company!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("First Name :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.firstName!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Last Name :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.lastName!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Address :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.address1!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Country :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.country!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("State/Province :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.stateOrProvince!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("City :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.city!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Zip/Postcode :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.postalCode!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Row(
                          children: [
                            text("Phone Number :",
                                fontWeight: FontWeight.bold, fontSize: 10.sp),
                            const Spacer(),
                            text(
                                widget.checkoutModel.data!.consignments![0]
                                    .shippingAddress!.phone!,
                                fontSize: 10.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              sizedboxWidget(),

              text("Shipping Method",
                  fontSize: 12.sp, fontWeight: FontWeight.bold),

              sizedboxWidget(),

              widget.checkoutModel.data!.consignments!.isNotEmpty
                  ? Column(
                      children: [
                        for (int indexx = 0;
                            indexx <
                                widget.checkoutModel.data!.consignments!.length;
                            indexx++)
                          Card(
                            elevation: 3,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(0.2.h),
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          widget
                                              .checkoutModel
                                              .data!
                                              .consignments![indexx]
                                              .availableShippingOptions!
                                              .length;
                                      i++)
                                    Padding(
                                      padding: EdgeInsets.all(0.2.h),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: 0.1.h,
                                            child: Radio(
                                              value: widget
                                                  .checkoutModel
                                                  .data!
                                                  .consignments![indexx]
                                                  .availableShippingOptions![i]
                                                  .description,
                                              groupValue:
                                                  _selectedShippingMethod,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedShippingMethod =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          text(
                                              widget
                                                  .checkoutModel
                                                  .data!
                                                  .consignments![indexx]
                                                  .availableShippingOptions![i]
                                                  .description!,
                                              fontSize: 10.sp),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    )
                  : Container(),

              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: widget.checkoutModel.data!.consignments!.length,
              //   itemBuilder: (context, index) {
              //     var consignment =
              //         widget.checkoutModel.data!.consignments![index];
              //     var availableOptions =
              //         consignment.availableShippingOptions ?? [];

              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: availableOptions.map((option) {
              //             return ListTile(
              //               title: Text(option.description ?? ''),
              //               leading: Radio<String>(
              //                 value: option.id ?? '',
              //                 groupValue: _selectedShippingMethod,
              //                 onChanged: (value) {
              //                   setState(() {
              //                     _selectedShippingMethod = value;
              //                   });
              //                 },
              //               ),
              //             );
              //           }).toList(),
              //         ),
              //         const SizedBox(height: 20),
              //       ],
              //     );
              //   },
              // ),

              sizedboxWidget(),

              TextButton(
                onPressed: () async {
                  BillingCheckoutModel? billingCheckoutModel;
                  await pl.show();
                  billingCheckoutModel = await apis.checkoutBillingApi(
                      pl,
                      widget.checkoutModel.data!.id!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.firstName!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.lastName!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.email!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.company!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.address1!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.address2!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.city!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.stateOrProvince!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.stateOrProvinceCode!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.countryCode!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.postalCode!,
                      widget.checkoutModel.data!.consignments![0]
                          .shippingAddress!.phone!,
                      context,
                      widget.toggleTheme);
                  if (billingCheckoutModel != null) {
                    // await apis.ordercheckoutApi(
                    //   pl,
                    //   context,
                    //   widget.checkoutModel.data!.id!,
                    //   widget.toggleTheme,
                    // );
                    await apis.getPaymetMethodApi(
                      pl,
                      context,
                      widget.toggleTheme,
                      SpUtil.getInt(SpConstUtil.orderID),
                      widget.checkoutModel.data!.id!,
                    );
                  }

                  await pl.hide();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: colors.themebluecolor),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 3.h, right: 3.h, top: 1.h, bottom: 1.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          text("Continue",
                              color: colors.whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp),
                          SizedBox(
                            width: 2.w,
                          ),
                          Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.whitecolor)),
                            child: Padding(
                              padding: EdgeInsets.all(0.7.h),
                              child: Image.asset(
                                "assets/png/next.png",
                                color: colors.whitecolor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

  // StreamBuilder<CheckoutConsignmentsUpdateModel> shippingAddressWidget(
  //     ProgressLoader pl) {
  //   return StreamBuilder<CheckoutConsignmentsUpdateModel>(
  //       stream: updateCheckoutBloc.parentcategoryStream,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               text14new(snapshot.error,
  //                   color: Colors.blue, fontWeight: FontWeight.bold),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Center(
  //                 child: SizedBox(
  //                   height: 40,
  //                   // width: 70,
  //                   child: ElevatedButton(
  //                       onPressed: () async {},
  //                       child: text14("Retry", FontWeight.bold)),
  //                 ),
  //               ),
  //             ],
  //           );
  //         } else if (snapshot.hasData) {
  //           return SingleChildScrollView(
  //               physics: const BouncingScrollPhysics(),
  //               child: Padding(
  //                 padding: EdgeInsets.all(1.0.h),
  //                 child:
  //                     //  Form(
  //                     //   key: _formKey,
  //                     //   child:
  //                     Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     text("Shipping & Billing Address",
  //                         fontSize: 12.sp, fontWeight: FontWeight.bold),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),

  //                     Card(
  //                       elevation: 3,
  //                       surfaceTintColor: Colors.white,
  //                       child: Padding(
  //                         padding: EdgeInsets.all(0.2.h),
  //                         child: Column(
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Company :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.company!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("First Name :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.firstName!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Last Name :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.lastName!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Address :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.address1!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Country :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.country!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("State/Province :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.stateOrProvince!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("City :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.city!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Zip/Postcode :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.postalCode!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.all(1.h),
  //                               child: Row(
  //                                 children: [
  //                                   text("Phone Number :",
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 10.sp),
  //                                   const Spacer(),
  //                                   text(
  //                                       snapshot.data!.data!.consignments![0]
  //                                           .shippingAddress!.phone!,
  //                                       fontSize: 10.sp),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),

  //                     SizedBox(
  //                        sizedboxWidget(),
  //                     ),
  //                     text("Shipping Method",
  //                         fontSize: 12.sp, fontWeight: FontWeight.bold),
  //                     SizedBox(
  //                        sizedboxWidget(),
  //                     ),
  //                     widget.checkoutModel.data!.consignments!.isNotEmpty
  //                         ? Column(
  //                             children: [
  //                               for (int indexx = 0;
  //                                   indexx <
  //                                       widget.checkoutModel.data!.consignments!
  //                                           .length;
  //                                   indexx++)
  //                                 Card(
  //                                   elevation: 3,
  //                                   surfaceTintColor: Colors.white,
  //                                   child: Padding(
  //                                     padding: EdgeInsets.all(0.2.h),
  //                                     child: Column(
  //                                       children: [
  //                                         for (int i = 0;
  //                                             i <
  //                                                 widget
  //                                                     .checkoutModel
  //                                                     .data!
  //                                                     .consignments![indexx]
  //                                                     .availableShippingOptions!
  //                                                     .length;
  //                                             i++)
  //                                           Padding(
  //                                             padding: EdgeInsets.all(0.2.h),
  //                                             child: Row(
  //                                               children: [
  //                                                 Transform.scale(
  //                                                   scale: 0.1.h,
  //                                                   child: Radio(
  //                                                     value: widget
  //                                                         .checkoutModel
  //                                                         .data!
  //                                                         .consignments![indexx]
  //                                                         .availableShippingOptions![
  //                                                             i]
  //                                                         .description,
  //                                                     groupValue:
  //                                                         _selectedShippingMethod,
  //                                                     onChanged: (value) {
  //                                                       setState(() {
  //                                                         _selectedShippingMethod =
  //                                                             value.toString();
  //                                                       });
  //                                                     },
  //                                                   ),
  //                                                 ),
  //                                                 SizedBox(
  //                                                   width: 1.w,
  //                                                 ),
  //                                                 text(
  //                                                     widget
  //                                                         .checkoutModel
  //                                                         .data!
  //                                                         .consignments![indexx]
  //                                                         .availableShippingOptions![
  //                                                             i]
  //                                                         .description!,
  //                                                     fontSize: 10.sp),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                             ],
  //                           )
  //                         : Container(),

  //                     // ListView.builder(
  //                     //   physics: const NeverScrollableScrollPhysics(),
  //                     //   shrinkWrap: true,
  //                     //   itemCount: widget.checkoutModel.data!.consignments!.length,
  //                     //   itemBuilder: (context, index) {
  //                     //     var consignment =
  //                     //         widget.checkoutModel.data!.consignments![index];
  //                     //     var availableOptions =
  //                     //         consignment.availableShippingOptions ?? [];

  //                     //     return Column(
  //                     //       crossAxisAlignment: CrossAxisAlignment.start,
  //                     //       children: [
  //                     //         Column(
  //                     //           crossAxisAlignment: CrossAxisAlignment.start,
  //                     //           children: availableOptions.map((option) {
  //                     //             return ListTile(
  //                     //               title: Text(option.description ?? ''),
  //                     //               leading: Radio<String>(
  //                     //                 value: option.id ?? '',
  //                     //                 groupValue: _selectedShippingMethod,
  //                     //                 onChanged: (value) {
  //                     //                   setState(() {
  //                     //                     _selectedShippingMethod = value;
  //                     //                   });
  //                     //                 },
  //                     //               ),
  //                     //             );
  //                     //           }).toList(),
  //                     //         ),
  //                     //         const SizedBox(height: 20),
  //                     //       ],
  //                     //     );
  //                     //   },
  //                     // ),

  //                     SizedBox(
  //                        sizedboxWidget(),
  //                     ),
  //                     TextButton(
  //                       onPressed: () async {
  //                         // await Navigator.push(
  //                         //     context,
  //                         //     MaterialPageRoute(
  //                         //         builder: (context) => PaymentScreen(
  //                         //               billingCheckoutModel:
  //                         //                   snapshot.data!,
  //                         //               toggleTheme: widget.toggleTheme,
  //                         //             )));
  //                         List<Map<String, dynamic>> lineItems = snapshot
  //                             .data!.data!.cart!.lineItems!.physicalItems!
  //                             .map((variantData) {
  //                           return {
  //                             "quantity": variantData.quantity,
  //                             "product_id": variantData.productId,
  //                             "variant_id": variantData.variantId,
  //                           };
  //                         }).toList();
  //                         // await pl.show();
  //                         // await apis.createAnOrderApi(
  //                         //     snapshot.data!.data!.id!,
  //                         //     snapshot.data!.data!.billingAddress!.firstName!,
  //                         //     snapshot.data!.data!.billingAddress!.lastName!,
  //                         //     snapshot.data!.data!.billingAddress!.address1!,
  //                         //     snapshot.data!.data!.billingAddress!.city!,
  //                         //     snapshot
  //                         //         .data!.data!.billingAddress!.stateOrProvince!,
  //                         //     snapshot.data!.data!.billingAddress!.postalCode!,
  //                         //     snapshot.data!.data!.billingAddress!.country!,
  //                         //     snapshot.data!.data!.billingAddress!.countryCode!,
  //                         //     snapshot.data!.data!.billingAddress!.email!,
  //                         //     lineItems,
  //                         //     pl,
  //                         //     context,
  //                         //     widget.toggleTheme);
  //                         // await pl.hide();
  //                         await Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => PaymentScreen(
  //                                       toggleTheme: widget.toggleTheme,
  //                                       // cartID: snapshot.data!.data!.id!,
  //                                       // firstName: snapshot.data!.data!
  //                                       //     .billingAddress!.firstName!,
  //                                       lineItems: lineItems,
  //                                       data: snapshot.data!.data!,
  //                                       // id:  snapshot.data!.data!.id!,
  //                                     )));
  //                       },
  //                       child: Align(
  //                         alignment: Alignment.centerRight,
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(1.h),
  //                               color: colors.themebluecolor),
  //                           child: Padding(
  //                             padding: EdgeInsets.only(
  //                                 left: 3.h, right: 3.h, top: 1.h, bottom: 1.h),
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 text("Continue",
  //                                     color: colors.whitecolor,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 10.sp),
  //                                 SizedBox(
  //                                   width: 2.w,
  //                                 ),
  //                                 Container(
  //                                   height: 3.h,
  //                                   width: 3.h,
  //                                   decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       border: Border.all(
  //                                           color: colors.whitecolor)),
  //                                   child: Padding(
  //                                     padding: EdgeInsets.all(0.7.h),
  //                                     child: Image.asset(
  //                                       "assets/png/next.png",
  //                                       color: colors.whitecolor,
  //                                     ),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ));
  //         } else {
  //           updateCheckoutBloc.updateCheckoutBloc(
  //               pl,
  //               widget.checkoutModel.data!.consignments![0].id!,
  //               widget.checkoutModel.data!.id!,
  //               widget.toggleTheme,
  //               widget.checkoutModel.data!.consignments![0]
  //                   .availableShippingOptions![2].id!,
  //               context);
  //           return Center(
  //             child: CupertinoActivityIndicator(
  //               radius: 1.4.h,
  //             ),
  //           );
  //         }
  //       });
  // }

