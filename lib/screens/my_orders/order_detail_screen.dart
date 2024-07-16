// ignore_for_file: must_be_immutable

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/bloc/get_order_detail_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/my_orders_shimmer.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/model/get_my_order_details_model.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OrderDetailScreen extends StatefulWidget {
  var orderId;
  OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // List stepperStatus = [
  //   "Pending",
  //   "Awaiting Payment",
  //   "Awaiting Fullfillment",
  //   "Awaiting Shipment",
  //   "Awaiting Pickup",
  //   "Partially Shipped",
  //   "Completed",
  //   "Shipped",
  //   "Cancelled",
  //   "Declined",
  //   "Refunded",
  //   "Disputed",
  //   "Manual Verification Required",
  //   "Partially Refunded"
  // ];

  @override
  Widget build(BuildContext context) {
    // stepperStatus.indexOf(widget.snapshot.status);
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      // appBar: AppBar(
      //   leadingWidth: 14.w,
      //   scrolledUnderElevation: 0,
      //   toolbarHeight: MediaQuery.of(context).size.height / 18,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   leading: TextButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     child: Container(
      //       height: 4.h,
      //       width: 4.h,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         border: Border.all(
      //             color: SpUtil.getBool(SpConstUtil.appTheme)!
      //                 ? colors.whitecolor
      //                 : colors.blackcolor),
      //       ),
      //       child: Padding(
      //         padding: EdgeInsets.all(0.7.h),
      //         child: Image.asset(
      //           "assets/png/next.png",
      //           color: SpUtil.getBool(SpConstUtil.appTheme)!
      //               ? colors.whitecolor
      //               : colors.blackcolor,
      //         ),
      //       ),
      //     ),
      //   ),
      //   // backgroundColor: colors.themebluecolor,
      //   title: text("Order Details",
      //       fontSize: 13.sp,
      //       fontWeight: FontWeight.bold,
      //       color: SpUtil.getBool(SpConstUtil.appTheme)!
      //           ? colors.whitecolor
      //           : colors.blackcolor),
      // ),
      body: orderDetailWidget(pl),
    );
  }

  Widget orderDetailWidget(ProgressLoader pl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 4.2.h,
                    width: 4.2.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //   color: SpUtil.getBool(SpConstUtil.appTheme)!
                      //       ? colors.whitecolor
                      //       : colors.blackcolor,
                      // ),
                      color: colors.kSecondaryColor.withOpacity(0.2),
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

                text(
                  "Order Details",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor,
                ),

                // ),
                // )
              ],
            ),
          ),
          StreamBuilder<GetMyOrdersDetailsModel>(
              stream: getAllOrderDetailBloc.getAllorderDetailcategoryStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      text14new(snapshot.error,
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                          height: 40,
                          // width: 70,
                          child: ElevatedButton(
                              onPressed: () async {
                                await pl.show();
                                await getAllOrderDetailBloc
                                    .getAllrderDeatilsBloc(pl, widget.orderId)
                                    .catchError((error) async {
                                  if (pl.isShowing()) {
                                    await pl.hide();
                                  }
                                });
                                await pl.hide();
                              },
                              child: text14("Retry", FontWeight.bold)),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        color: SpUtil.getBool(
                                                SpConstUtil.appTheme)!
                                            ? colors.whitecolor.withOpacity(0.3)
                                            : colors.themebluecolor),
                                    child: Padding(
                                      padding: EdgeInsets.all(1.5.h),
                                      child: text(
                                          "Order #${snapshot.data!.data!.id}",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: SpUtil.getBool(
                                                  SpConstUtil.appTheme)!
                                              ? colors.whitecolor
                                              : colors.whitecolor),
                                    ),
                                  ),

                                  sizedboxWidget(),

                                  text("Order Contents",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),

                                  sizedboxWidget(),

                                  Card(
                                    elevation: 3,
                                    surfaceTintColor: Colors.white,
                                    child: Padding(
                                        padding: EdgeInsets.all(1.5.h),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data!.data!.products!.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.h,
                                                          right: 1.h,
                                                          top: 0.7.h,
                                                          bottom: 0.7.h),
                                                      child: Row(
                                                        children: [
                                                          text(
                                                              "${snapshot.data!.data!.products![i].quantity}",
                                                              fontSize: 10.sp),
                                                          Image.asset(
                                                            "assets/png/cross.png",
                                                            height: 3.h,
                                                            width: 3.h,
                                                            color: SpUtil.getBool(
                                                                    SpConstUtil
                                                                        .appTheme)!
                                                                ? colors
                                                                    .whitecolor
                                                                : colors
                                                                    .blackcolor,
                                                          ),
                                                          Expanded(
                                                            child: text(
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .products![
                                                                        i]
                                                                    .name!,
                                                                fontSize: 9.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    for (int j = 0;
                                                        j <
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .products![i]
                                                                .productOptions!
                                                                .length;
                                                        j++)
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 1.h,
                                                                right: 1.h,
                                                                top: 0.7.h,
                                                                bottom: 0.7.h),
                                                        child: Row(
                                                          children: [
                                                            text(
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .products![
                                                                        i]
                                                                    .productOptions![
                                                                        j]
                                                                    .displayName!,
                                                                fontSize: 9.sp),
                                                            const Spacer(),
                                                            text(
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .products![
                                                                        i]
                                                                    .productOptions![
                                                                        j]
                                                                    .displayValue!,
                                                                fontSize: 9.sp),
                                                          ],
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(1.h),
                                                      child: MySeparator(
                                                        color: colors.greyColor,
                                                        height: 0.1.h,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(1.h),
                                              child: Row(
                                                children: [
                                                  text("Sub Total:",
                                                      fontSize: 10.sp),
                                                  const Spacer(),
                                                  text(
                                                      snapshot.data!.data!
                                                          .subtotalIncTax!,
                                                      fontSize: 11.sp),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(1.h),
                                              child: Row(
                                                children: [
                                                  text("Grand Total:",
                                                      fontSize: 11.sp),
                                                  const Spacer(),
                                                  text(
                                                      snapshot.data!.data!
                                                          .totalIncTax!,
                                                      fontSize: 11.sp),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),

                                  sizedboxWidget(),

                                  text("Order Details",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),

                                  sizedboxWidget(),

                                  Card(
                                    elevation: 3,
                                    surfaceTintColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Order status:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        snapshot.data!.data!
                                                            .status!,
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Order date:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        DateFormat(
                                                                'MMM dd\'th\' yyyy')
                                                            .format(DateFormat(
                                                                    'E, dd MMM yyyy HH:mm:ss Z')
                                                                .parse(
                                                                    "${snapshot.data!.data!.dateCreated}")),
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Order Total:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        snapshot.data!.data!
                                                            .totalIncTax!,
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Payment method:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        snapshot.data!.data!
                                                            .paymentMethod!,
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Created By:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        "${snapshot.data!.data!.billingAddress!.firstName} ${snapshot.data!.data!.billingAddress!.lastName}",
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Email:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        "${snapshot.data!.data!.billingAddress!.email}",
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Row(
                                                  children: [
                                                    text("Last Updated:",
                                                        fontSize: 10.sp),
                                                    const Spacer(),
                                                    text(
                                                        DateFormat(
                                                                'MMM dd\'th\' yyyy')
                                                            .format(DateFormat(
                                                                    'E, dd MMM yyyy HH:mm:ss Z')
                                                                .parse(
                                                                    "${snapshot.data!.data!.dateModified}")),
                                                        fontSize: 10.sp),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.h),
                                                    color: SpUtil.getBool(
                                                            SpConstUtil
                                                                .appTheme)!
                                                        ? colors.whitecolor
                                                        : colors
                                                            .themebluecolor),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(1.0.h),
                                                  child: text("Print Invoice",
                                                      color: SpUtil.getBool(
                                                              SpConstUtil
                                                                  .appTheme)!
                                                          ? colors.blackcolor
                                                          : colors.whitecolor,
                                                      fontSize: 10.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  sizedboxWidget(),

                                  text("Ship To",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),

                                  sizedboxWidget(),

                                  Card(
                                    elevation: 3,
                                    surfaceTintColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: EdgeInsets.all(1.5.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.shippingAddress![0].firstName} ${snapshot.data!.data!.shippingAddress![0].lastName}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.shippingAddress![0].company}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.shippingAddress![0].street1}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.shippingAddress![0].city}, ${snapshot.data!.data!.shippingAddress![0].state} ${snapshot.data!.data!.shippingAddress![0].zip}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.shippingAddress![0].country}",
                                                    fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  sizedboxWidget(),

                                  text("Bill To",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),

                                  sizedboxWidget(),

                                  Card(
                                    elevation: 3,
                                    surfaceTintColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: EdgeInsets.all(1.5.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.billingAddress!.firstName} ${snapshot.data!.data!.billingAddress!.lastName}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.billingAddress!.company}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.billingAddress!.street1}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.billingAddress!.city}, ${snapshot.data!.data!.billingAddress!.state} ${snapshot.data!.data!.billingAddress!.zip}",
                                                    fontSize: 10.sp),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: text(
                                                    "${snapshot.data!.data!.billingAddress!.country}",
                                                    fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  sizedboxWidget(),

                                  // text("Order Status",
                                  //     fontSize: 18, fontWeight: FontWeight.bold),
                                  // const SizedBox(
                                  //    sizedboxWidget(),
                                  // ),
                                  // Card(
                                  //   elevation: 3,
                                  //   surfaceTintColor: Colors.white,
                                  //   child: Container(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(12.0),
                                  //       child: Column(
                                  //         children: [
                                  //           for (int i = 0; i < stepperStatus.length; i++)
                                  //             Container(
                                  //               child: customStepperWidget(
                                  //                 stepperStatus[i],
                                  //                 i == stepperStatus.length - 1,
                                  //                 currentIndex,
                                  //                 i,
                                  //               ),
                                  //             )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 7.sp, top: 7.sp),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.h, right: 2.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: SpUtil.getBool(
                                                    SpConstUtil.appTheme)!
                                                ? colors.whitecolor
                                                : colors.themebluecolor,
                                            shape: const StadiumBorder()),
                                        onPressed: () async {
                                          List<Map<String, dynamic>> lineItems =
                                              snapshot.data!.data!.products!
                                                  .map((variantData) {
                                            return {
                                              "quantity": variantData.quantity,
                                              "product_id":
                                                  variantData.productId,
                                              "variant_id":
                                                  variantData.variantId,
                                            };
                                          }).toList();

                                          if (SpUtil.getString(
                                                  SpConstUtil.cartID) ==
                                              "") {
                                            await pl.show();
                                            await apis.addToCartProductsApi(
                                                lineItems, pl, setState);
                                            await pl.hide();
                                          } else {
                                            await pl.show();

                                            await apis.addToCartNewApi(
                                                lineItems,
                                                SpUtil.getString(
                                                    SpConstUtil.cartID)!,
                                                pl,
                                                setState);
                                            await pl.hide();
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(0.7.h),
                                          child: text("Reorder",
                                              color: SpUtil.getBool(
                                                      SpConstUtil.appTheme)!
                                                  ? colors.blackcolor
                                                  : colors.whitecolor,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            // backgroundColor: Colors.transparent,
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color: SpUtil.getBool(
                                                            SpConstUtil
                                                                .appTheme)!
                                                        ? colors.whitecolor
                                                        : colors
                                                            .themebluecolor))),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(0.7.h),
                                          child: text("Add to Wish List",
                                              color: SpUtil.getBool(
                                                      SpConstUtil.appTheme)!
                                                  ? colors.whitecolor
                                                  : colors.themebluecolor,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  getAllOrderDetailBloc.getAllrderDeatilsBloc(
                      pl, widget.orderId);
                  return const Expanded(
                      child:
                          //      Center(
                          //         child: CupertinoActivityIndicator(
                          //   radius: 1.4.h,
                          // )

                          // )
                          Center(child: OrderDetailShimmer()));
                }
              }),
        ],
      ),
    );
  }

  Widget customStepperWidget(
      String title, bool isLast, int currentIndex, index) {
    final bool isActive = index <= currentIndex;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isActive ? Colors.green : colors.greyColor,
                  ),
                  shape: BoxShape.circle),
              child: Image.asset(
                "assets/png/dot_icon.png",
                color: isActive ? Colors.green : colors.greyColor,
              ),
            ),
            if (!isLast)
              Dash(
                dashThickness: isActive ? 2 : 1,
                direction: Axis.vertical,
                length: 60,
                dashLength: 5,
                dashColor: isActive ? Colors.green : colors.greyColor,
              ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        text(title,
            color: isActive
                ? Colors.green
                : SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor
                    : colors.blackcolor)
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (1.8 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
