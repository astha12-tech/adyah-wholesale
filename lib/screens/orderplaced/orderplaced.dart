// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/bottom_navigation_bar.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderPlacedSuccessScreen extends StatefulWidget {
  int orderID;
  String firstName;
  void Function() toggleTheme;
  OrderPlacedSuccessScreen(
      {super.key,
      required this.toggleTheme,
      required this.orderID,
      required this.firstName});

  @override
  State<OrderPlacedSuccessScreen> createState() =>
      _OrderPlacedSuccessScreenState();
}

class _OrderPlacedSuccessScreenState extends State<OrderPlacedSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                BottomNavigationBarScreen(toggleTheme: widget.toggleTheme),
          ),
          (route) => false,
        );
        setState(() {});

        return true;
      },
      child: Scaffold(
        body: orderPlacedWidget(context),
      ),
    );
  }

  Column orderPlacedWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2), shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(
                "assets/png/work-order.png",
                height: 50,
                width: 50,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        text("Thank you ${widget.firstName}!",
            fontSize: 18.sp, fontWeight: FontWeight.bold),
        SizedBox(
          height: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text("Your order number is ", fontSize: 10.sp),
            text("${widget.orderID}",
                fontWeight: FontWeight.bold, fontSize: 10.sp),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          child: Text(
            "Your order was sent to us but is currently awaiting payment. Once we receive the payment for your order, it will be completed. If you've already provided payment details then we will process your order manually and send you an email when it's completed.",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "OpenSans", fontSize: 8.sp),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          child: Text(
            "Please contact your sales rep to arrange and confirm the payment total so we can process your order without any delays.",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "OpenSans", fontSize: 8.sp),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    BottomNavigationBarScreen(toggleTheme: widget.toggleTheme),
              ),
              (route) => false,
            );
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: colors.greyColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: text("CONTINUE SHOPPING »", fontSize: 8.sp),
            ),
          ),
        )
      ],
    );
  }
}
