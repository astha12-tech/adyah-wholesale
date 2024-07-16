// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/card/card_date_validator.dart';
import 'package:adyah_wholesale/card/card_number_validator.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';

import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  void Function() toggleTheme;
  var data;
  var cartID;

  PaymentScreen({
    super.key,
    required this.toggleTheme,
    required this.data,
    required this.cartID,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // List paymentOptionsList = [
  //   "COD",
  //   "Authorize.Net",
  // ];
  // String selectedRadio = "COD";
  String selectedInstrument = "COD";
  CardTypee _cardType = CardTypee.unknown;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardMonthYearController = TextEditingController();
  String? monthYearValue;

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    debugPrint("==== widget data ====> ${widget.data}");

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
        body: paymentCODWidget(pl, context)
        //  paymentWidget(pl, context),
        );
  }

  Padding paymentCODWidget(ProgressLoader pl, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          text("Payment", fontSize: 12.sp, fontWeight: FontWeight.bold),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0.2.h),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.1.h,
                      child: Radio(
                        value: selectedInstrument,
                        groupValue: selectedInstrument,
                        onChanged: (value) {
                          setState(() {
                            selectedInstrument = value!;
                            debugPrint(
                                "==== selectedInstrument ===>$selectedInstrument");
                          });
                        },
                      ),
                    ),
                    text("COD", fontSize: 10.sp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: () async {
              if (selectedInstrument == "COD") {
                await pl.show();
                await apis.ordercheckoutApi(
                    pl, context, widget.cartID, widget.toggleTheme, setState);
                // await apis.ordercheckoutUpdateApi(
                //     pl, context, widget.cartID, widget.toggleTheme, setState);
                // await apis.createAnOrderApi(
                //   widget.cartID,
                //   widget.firstName,
                //   widget.lastName,
                //   widget.street1,
                //   widget.city,
                //   widget.state,
                //   widget.zip,
                //   widget.country,
                //   widget.countrycode,
                //   widget.email,
                //   widget.lineItems,
                //   pl,
                //   context,
                //   widget.toggleTheme,
                // );
                await pl.hide();
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: selectedInstrument == "COD"
                      ? colors.themebluecolor
                      : colors.greyColor.withOpacity(0.3)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Center(
                  child: text("PLACE ORDER",
                      color: colors.whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding paymentWidget(ProgressLoader pl, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          text("Payment", fontSize: 12.sp, fontWeight: FontWeight.bold),
          Column(
            children: [
              for (int i = 0; i < widget.data.length; i++)
                Padding(
                  padding: EdgeInsets.all(0.2.h),
                  child: Row(
                    children: [
                      Transform.scale(
                        
                        scale: 0.1.h,
                        child: Radio(
                          value: widget.data[i]['name'],
                          groupValue: selectedInstrument,
                          onChanged: (value) {
                            setState(() {
                              selectedInstrument = value;
                              debugPrint(
                                  "==== selectedInstrument ===>$selectedInstrument");
                            });
                          },
                        ),
                      ),
                      text(widget.data[i]['name'], fontSize: 10.sp)
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          selectedInstrument == "Authorize.Net"
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cardNumberController,
                      decoration: InputDecoration(
                          prefix: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child:
                                  CardNumberValidator.getCardIcon(_cardType)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          hintText: "XXXX-XXXX-XXXX-XXXX",
                          labelText: "Card Number",
                          counterText: '',
                          isDense: true),
                      maxLength: 19,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _cardType = CardNumberValidator.getCardType(value);
                          debugPrint("==== _cardType ==>>>>>>>$_cardType");
                        });
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberFormatter()
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: cardHolderNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Card Holder Name',
                          labelStyle: TextStyle(color: colors.blackcolor),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        debugPrint("== value ==>$value");
                        setState(() {
                          monthYearValue = value;
                          debugPrint("== monthYearValue ==>$monthYearValue");
                          String month = monthYearValue!.substring(0, 2);
                          String year = monthYearValue!.substring(3, 5);
                          debugPrint("Month: $month");
                          debugPrint("Year: $year");
                        });
                      },
                      controller: cardMonthYearController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          labelText: 'Month/Year',
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardDateFormatter()
                      ],
                    )
                  ],
                )
              : Container(),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: () async {
              await pl.show();
              apis.generatePaymentAccessTokenApi(
                  pl,
                  SpUtil.getInt(SpConstUtil.orderID),
                  2000 + int.parse(monthYearValue!.substring(3, 5)),
                  int.parse(monthYearValue!.substring(0, 2)),
                  cardHolderNameController.text,
                  cardNumberController.text);
              await pl.hide();
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: colors.themebluecolor),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Center(
                  child: text("PLACE ORDER",
                      color: colors.whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
