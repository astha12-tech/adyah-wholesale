import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/bloc/cart_all_data_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text16.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/cart_data_model.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CartScreenn extends StatefulWidget {
  String allcartDataids;
  String title;
  void Function() toggleTheme;

  CartScreenn(
      {super.key,
      required this.allcartDataids,
      required this.title,
      required this.toggleTheme});

  @override
  State<CartScreenn> createState() => _CartScreennState();
}

class _CartScreennState extends State<CartScreenn> {
  int qty = 0;
  double totalQuantity = 0;

  void calculateTotalQuantity(AsyncSnapshot<CartDataModel> snapshot) async {
    totalQuantity = 0;

    if (snapshot.data != null &&
        snapshot.data!.data != null &&
        snapshot.data!.data!.lineItems != null &&
        snapshot.data!.data!.lineItems!.physicalItems != null) {
      for (var item in snapshot.data!.data!.lineItems!.physicalItems!) {
        totalQuantity += item.quantity!;
      }
      await SpUtil.putDouble(SpConstUtil.totalqty, totalQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      // appBar: cartAppbar(context),
      body: cartWidget(pl),
    );
  }

  Widget cartWidget(ProgressLoader pl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          widget.title == ""
              ? Padding(
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
                        "My Cart",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor,
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    text(
                      "C A R T",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.blackcolor,
                    ),
                  ],
                ),
          Expanded(
            child: StreamBuilder<CartDataModel>(
                stream: cartDataBloc.cartDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return snapshot.error == "No Cart Found"
                        ? Center(
                            child: text("Empty Cart"),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              text14new(snapshot.error,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await pl.show();
                                        await cartDataBloc
                                            .cartDataBlocc(
                                                widget.allcartDataids,
                                                pl,
                                                setState)
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
                    return snapshot
                            .data!.data!.lineItems!.physicalItems!.isEmpty
                        ? Center(
                            child: text16(
                                "No data", colors.blackcolor, fontWeight.bold),
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 3,
                                      width: double.infinity,
                                      color: colors.greyColor.withOpacity(0.2),
                                    );
                                  },
                                  itemCount: snapshot.data!.data!.lineItems!
                                      .physicalItems!.length,
                                  itemBuilder: (context, index) {
                                    calculateTotalQuantity(snapshot);
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    7,
                                                margin: const EdgeInsets.only(
                                                    right: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 1.4.h,
                                                                ),
                                                              ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                      imageUrl: snapshot
                                                          .data!
                                                          .data!
                                                          .lineItems!
                                                          .physicalItems![index]
                                                          .imageUrl!,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data!
                                                          .lineItems!
                                                          .physicalItems![index]
                                                          .name!,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              60,
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    text(
                                                        "\$${snapshot.data!.data!.lineItems!.physicalItems![index].listPrice.toString()}",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            80,
                                                        fontWeight:
                                                            fontWeight.bold),
                                                    snapshot
                                                            .data!
                                                            .data!
                                                            .lineItems!
                                                            .physicalItems![
                                                                index]
                                                            .options!
                                                            .isEmpty
                                                        ? Container()
                                                        : const SizedBox(
                                                            height: 5,
                                                          ),
                                                    snapshot
                                                            .data!
                                                            .data!
                                                            .lineItems!
                                                            .physicalItems![
                                                                index]
                                                            .options!
                                                            .isEmpty
                                                        ? Container()
                                                        : Row(
                                                            children: [
                                                              Flexible(
                                                                flex: 2,
                                                                child: text(
                                                                    "${snapshot.data!.data!.lineItems!.physicalItems![index].options![0].name}: ",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        70),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .lineItems!
                                                                      .physicalItems![
                                                                          index]
                                                                      .options![
                                                                          0]
                                                                      .value!,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.height /
                                                                              70,
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    snapshot
                                                            .data!
                                                            .data!
                                                            .lineItems!
                                                            .physicalItems![
                                                                index]
                                                            .options!
                                                            .isEmpty
                                                        ? Container()
                                                        : const SizedBox(
                                                            height: 5,
                                                          ),
                                                    snapshot
                                                            .data!
                                                            .data!
                                                            .lineItems!
                                                            .physicalItems![
                                                                index]
                                                            .options!
                                                            .isEmpty
                                                        ? Container()
                                                        : Row(
                                                            children: [
                                                              text(
                                                                  "${snapshot.data!.data!.lineItems!.physicalItems![index].options![1].name}: ",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      70),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .lineItems!
                                                                      .physicalItems![
                                                                          index]
                                                                      .options![
                                                                          1]
                                                                      .value!,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.height /
                                                                              70,
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              qty = snapshot
                                                                  .data!
                                                                  .data!
                                                                  .lineItems!
                                                                  .physicalItems![
                                                                      index]
                                                                  .quantity!;
                                                            });
                                                            if (qty > 1) {
                                                              qty--;

                                                              await pl.show();

                                                              await apis.updateQty(
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .id!,
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .lineItems!
                                                                      .physicalItems![
                                                                          index]
                                                                      .id!,
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .lineItems!
                                                                      .physicalItems![
                                                                          index]
                                                                      .productId!,
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .lineItems!
                                                                      .physicalItems![
                                                                          index]
                                                                      .variantId!,
                                                                  qty,
                                                                  pl,
                                                                  setState);

                                                              await pl.hide();
                                                            }
                                                          },
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                28,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                28,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: colors
                                                                        .themebluecolor)),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    54,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        text(
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .lineItems!
                                                                .physicalItems![
                                                                    index]
                                                                .quantity
                                                                .toString(),
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                45),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              qty = snapshot
                                                                  .data!
                                                                  .data!
                                                                  .lineItems!
                                                                  .physicalItems![
                                                                      index]
                                                                  .quantity!;
                                                            });

                                                            qty++;

                                                            await pl.show();

                                                            await apis.updateQty(
                                                                snapshot.data!
                                                                    .data!.id!,
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .lineItems!
                                                                    .physicalItems![
                                                                        index]
                                                                    .id!,
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .lineItems!
                                                                    .physicalItems![
                                                                        index]
                                                                    .productId!,
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .lineItems!
                                                                    .physicalItems![
                                                                        index]
                                                                    .variantId!,
                                                                qty,
                                                                pl,
                                                                setState);
                                                            cartDataBloc
                                                                .cartDataBlocc(
                                                                    widget
                                                                        .allcartDataids,
                                                                    pl,
                                                                    setState);

                                                            await pl.hide();
                                                          },
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                28,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                28,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: colors
                                                                        .themebluecolor)),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  54,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await pl.show();
                                                  await apis.deleteCartItems(
                                                      snapshot.data!.data!.id!,
                                                      snapshot
                                                          .data!
                                                          .data!
                                                          .lineItems!
                                                          .physicalItems![index]
                                                          .id!,
                                                      pl,
                                                      setState);
                                                  await pl.hide();
                                                },
                                                child: Container(
                                                  height: 3.h,
                                                  width: 3.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colors
                                                          .themebluecolor),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(0.3.h),
                                                    child: Image.asset(
                                                      "assets/png/cross.png",
                                                      color: colors.whitecolor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          text("Sub Total",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8.sp),
                                          const Spacer(),
                                          text(
                                              "\$${snapshot.data!.data!.baseAmount}",
                                              fontSize: 8.sp),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: List.generate(
                                            40,
                                            (index) => Expanded(
                                                    child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  height: 2,
                                                  color: Colors.grey.shade300,
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          text("Total",
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold),
                                          const Spacer(),
                                          text(
                                            "\$${snapshot.data!.data!.cartAmount}",
                                            fontSize: 11.sp,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      colors.themebluecolor,
                                                  shape: const StadiumBorder()),
                                              onPressed: () async {
                                                var physicalItems = snapshot
                                                    .data!
                                                    .data!
                                                    .lineItems!
                                                    .physicalItems!;

                                                List<Map<String, dynamic>>
                                                    lineItems =
                                                    physicalItems.map((item) {
                                                  return {
                                                    "item_id": item.id!,
                                                    "quantity": item.quantity!,
                                                  };
                                                }).toList();

                                                await pl.show();

                                                await apis
                                                    .checkoutconsignmentsApi(
                                                        pl,
                                                        snapshot
                                                            .data!.data!.id!,
                                                        lineItems,
                                                        context,
                                                        widget.toggleTheme);

                                                await pl.hide();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(1.7.h),
                                                child: text("Checkout",
                                                    color: colors.whitecolor,
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                  } else {
                    cartDataBloc.cartDataBlocc(
                        widget.allcartDataids, pl, setState);
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 1.4.h,
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  AppBar cartAppbar(BuildContext context) {
    return AppBar(
      leadingWidth: 14.w,
      leading: widget.title == "BottomBar"
          ? Container()
          : TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 4.h,
                width: 4.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.kSecondaryColor.withOpacity(0.2),
                  // border: Border.all(
                  //     color: SpUtil.getBool(SpConstUtil.appTheme)!
                  //         ? colors.whitecolor
                  //         : colors.blackcolor),
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
      scrolledUnderElevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height / 18,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: text("My Cart",
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor
              : colors.blackcolor),
    );
  }
}
