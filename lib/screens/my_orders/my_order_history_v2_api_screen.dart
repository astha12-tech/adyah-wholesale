// import 'package:adyah_wholesale/bloc/get_my_orders_bloc.dart';
// import 'package:adyah_wholesale/components/appbar/appbar_widget.dart';
// import 'package:adyah_wholesale/components/indicator/indicator.dart';
// import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
// import 'package:adyah_wholesale/components/shimmer_widget/my_orders_shimmer.dart';
// import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
// import 'package:adyah_wholesale/components/text_component/text14.dart';
// import 'package:adyah_wholesale/components/text_component/text.dart';
// import 'package:adyah_wholesale/model/get_my_orders_model.dart';
// import 'package:adyah_wholesale/screens/my_orders/order_detail_screen.dart';
// import 'package:adyah_wholesale/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';

// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({super.key});

//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }

// class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
//   String formatUnixTimestamp(String timestampString) {
//     // Parse the Unix timestamp string to an integer
//     int timestamp = int.parse(timestampString);

//     // Convert the Unix timestamp to a DateTime object
//     DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

//     // Format the DateTime object as per your requirement
//     String formattedDate = DateFormat('MMM dd\'th\' yyyy').format(date);

//     return formattedDate;
//   }

//   fun() {
//     String formattedDate = formatUnixTimestamp("1718249431");
//     debugPrint("yyyyyyy==> $formattedDate"); // Output: Feb 10th 2024
//   }

//   @override
//   void initState() {
//     fun();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ProgressLoader pl = ProgressLoader(context, isDismissible: false);
//     debugPrint(
//         "========== company id ========== ${SpUtil.getString(SpConstUtil.companyID)}");

//     return Scaffold(
//       appBar: appbar(context, "O R D E R S"),
//       body: orderHistoryWidget(pl),
//     );
//   }

//   StreamBuilder<GetMyOrdersModel> orderHistoryWidget(ProgressLoader pl) {
//     return StreamBuilder<GetMyOrdersModel>(
//         stream: getAllOrdersBloc.getAllordercategoryStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 text14new(snapshot.error,
//                     color: Colors.blue, fontWeight: FontWeight.bold),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Center(
//                   child: SizedBox(
//                     height: 40,
//                     // width: 70,
//                     child: ElevatedButton(
//                         onPressed: () async {
//                           await pl.show();
//                           await getAllOrdersBloc
//                               .getAllrderssBloc(pl)
//                               .catchError((error) async {
//                             if (pl.isShowing()) {
//                               await pl.hide();
//                             }
//                           });
//                           await pl.hide();
//                         },
//                         child: text14(
//                           "Retry",
//                           FontWeight.bold,
//                         )),
//                   ),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasData) {
//             return snapshot.data!.data!.isEmpty
//                 ? Center(
//                     child: text("No Data"),
//                   )
//                 : Column(
//                     children: [
//                       SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Row(
//                             children: [
//                               for (int i = 0; i < 8; i++)
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(30),
//                                         color: i == 0
//                                             ? colors.themebluecolor
//                                             : colors.themebluecolor
//                                                 .withOpacity(0.2)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: text("Awaiting Payment",
//                                           color: colors.whitecolor,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           physics: BouncingScrollPhysics(),
//                           child: Column(
//                             children: [
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const BouncingScrollPhysics(),
//                                 itemCount: snapshot.data!.data!.length,
//                                 itemBuilder: (context, index) {
//                                   return
//                                       // snapshot.data!.data![index].status == "Incomplete"
//                                       //     ? Container()
//                                       //     :
//                                       GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   OrderDetailScreen(
//                                                     orderId: snapshot
//                                                         .data!
//                                                         .data![index]
//                                                         .bcOrderId!,
//                                                   )));
//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.all(2.h),
//                                       child: Card(
//                                         elevation: 3,
//                                         surfaceTintColor: Colors.white,
//                                         child: Container(
//                                           color: Colors.transparent,
//                                           child: Padding(
//                                               padding: EdgeInsets.all(1.6.h),
//                                               child: Column(
//                                                 children: [
//                                                   orderTextWidget(
//                                                     "Order Number",
//                                                     "#${snapshot.data!.data![index].bcOrderId}",
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   orderTextWidget(
//                                                       "Poduct total",
//                                                       "\$${snapshot.data!.data![index].totalIncTax}"),
//                                                   const SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   // orderTextWidget("PO# / Reference#", ""),
//                                                   // const SizedBox(
//                                                   //   height: 8,
//                                                   // ),
//                                                   orderTextWidget(
//                                                       "Order Placed",
//                                                       DateFormat(
//                                                               'MMM dd\'th\' yyyy')
//                                                           .format(DateTime
//                                                               .fromMillisecondsSinceEpoch(
//                                                                   int.parse(
//                                                                           "${snapshot.data!.data![index].createdAt}") *
//                                                                       1000))),
//                                                   const SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   orderTextWidget(
//                                                       "Last Updated",
//                                                       DateFormat(
//                                                               'MMM dd\'th\' yyyy')
//                                                           .format(DateTime
//                                                               .fromMillisecondsSinceEpoch(
//                                                                   int.parse(
//                                                                           "${snapshot.data!.data![index].updatedAt}") *
//                                                                       1000))),
//                                                   const SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   orderTextWidget("Created By",
//                                                       "${SpUtil.getString(SpConstUtil.firstName)} ${SpUtil.getString(SpConstUtil.lastName)}"),
//                                                   const SizedBox(
//                                                     height: 15,
//                                                   ),
//                                                   MySeparator(
//                                                     color: colors.greyColor,
//                                                     height: 0.1.h,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 15,
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       text("STATUS",
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 10.sp),
//                                                       const Spacer(),
//                                                       Container(
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: SpUtil.getBool(
//                                                                   SpConstUtil
//                                                                       .appTheme)!
//                                                               ? colors
//                                                                   .whitecolor
//                                                               : colors
//                                                                   .themebluecolor,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   1.h),
//                                                           child: text(
//                                                               "${snapshot.data!.data![index].status}",
//                                                               color: SpUtil.getBool(
//                                                                       SpConstUtil
//                                                                           .appTheme)!
//                                                                   ? colors
//                                                                       .blackcolor
//                                                                   : colors
//                                                                       .whitecolor,
//                                                               fontSize: 10.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),

//                                                   sizedboxWidget(),

//                                                   Row(
//                                                     children: [
//                                                       text("ACTION",
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 10.sp),
//                                                       const Spacer(),
//                                                       // GestureDetector(
//                                                       //   onTap: () async {

//                                                       //   },
//                                                       //   child: Container(
//                                                       //     decoration: BoxDecoration(
//                                                       //       color: SpUtil.getBool(
//                                                       //               SpConstUtil.appTheme)!
//                                                       //           ? colors.whitecolor
//                                                       //           : colors.themebluecolor,
//                                                       //       borderRadius:
//                                                       //           BorderRadius.circular(10),
//                                                       //     ),
//                                                       //     child: Padding(
//                                                       //       padding: EdgeInsets.all(1.h),
//                                                       //       child: text("Reorder",
//                                                       //           color: SpUtil.getBool(
//                                                       //                   SpConstUtil
//                                                       //                       .appTheme)!
//                                                       //               ? colors.blackcolor
//                                                       //               : colors.whitecolor,
//                                                       //           fontSize: 10.sp,
//                                                       //           fontWeight:
//                                                       //               FontWeight.bold),
//                                                       //     ),
//                                                       //   ),
//                                                       // ),
//                                                       // SizedBox(
//                                                       //   width: 2.w,
//                                                       // ),
//                                                       Container(
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           // color: colors.whitecolor,
//                                                           border: Border.all(
//                                                             color: SpUtil.getBool(
//                                                                     SpConstUtil
//                                                                         .appTheme)!
//                                                                 ? colors
//                                                                     .whitecolor
//                                                                 : colors
//                                                                     .themebluecolor,
//                                                           ),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   1.h),
//                                                           child: text(
//                                                               "Add to Shopping List",
//                                                               color: SpUtil.getBool(
//                                                                       SpConstUtil
//                                                                           .appTheme)!
//                                                                   ? colors
//                                                                       .whitecolor
//                                                                   : colors
//                                                                       .themebluecolor,
//                                                               fontSize: 10.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               )),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//           } else {
//             getAllOrdersBloc.getAllrderssBloc(pl);
//             return const Center(child: MyOrdersShimmer());
//           }
//         });
//   }

//   Row orderTextWidget(String title, String value) {
//     return Row(
//       children: [
//         text(title, fontWeight: FontWeight.bold, fontSize: 10.sp),
//         const Spacer(),
//         text(value, fontWeight: FontWeight.normal, fontSize: 10.sp),
//       ],
//     );
//   }
// }
