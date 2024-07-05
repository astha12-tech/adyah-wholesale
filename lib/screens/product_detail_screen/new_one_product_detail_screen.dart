// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/cart_screen/cart_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/add_cart_button_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/description_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/page_view_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/qty_table_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/variant_data.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/variants_list_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/you_midht_also_like_product_widget.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetail extends StatefulWidget {
  String screen;
  var data;
  var productsMainCategoryModel;
  void Function() toggleTheme;
  ProductDetail(
      {super.key,
      required this.data,
      required this.productsMainCategoryModel,
      required this.screen,
      required this.toggleTheme});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedImage = 0;
  List<String> sizeLabels = [];
  int qty = 0;
  List<String> colorLabels = [];

  List<VariantData> variantDataList = [];
  TextEditingController controller = TextEditingController();

  String? allcartDataid;
  int? qtyy;
  int selectedImageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  addData() {
    if (widget.data.variants != null) {
      Set<String> uniqueSizes = {};

      for (var variant in widget.data.variants!) {
        if (variant.optionValues != null && variant.optionValues!.isNotEmpty) {
          String? sizeLabel = variant.optionValues![0].label;
          if (sizeLabel != null) {
            uniqueSizes.add(sizeLabel);
          }
        }
      }
      sizeLabels = uniqueSizes.toList();
      sizeLabels.sort();

      for (var variant in widget.data.variants!) {
        if (variant.optionValues != null && variant.optionValues!.length > 1) {
          String? colorLabel = variant.optionValues![1].label;
          if (colorLabel != null && !colorLabels.contains(colorLabel)) {
            colorLabels.add(colorLabel);
          }
        }
      }

      colorLabels.sort();
    }
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("==== ProductDetail ====");
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    // debugPrint(
    //     "=== SpUtil.getDouble(SpConstUtil.totalqty === ${SpUtil.getDouble(SpConstUtil.totalqty)}");

    return Scaffold(
      // appBar: productDetailAppbar(context, widget.toggleTheme, setState),
      body: Padding(
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
                        padding: EdgeInsets.all(0.99.h),
                        child: Image.asset(
                          "assets/png/back.png",
                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor
                              : colors.blackcolor,
                        ),
                      ),
                    ),
                  ),
                  text(
                    "Product Details",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: SpUtil.getBool(SpConstUtil.appTheme)!
                        ? colors.whitecolor
                        : colors.blackcolor,
                  ),
                  const Spacer(),
                  // TextButton(
                  //   onPressed: () async {
                  //     await Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => CartScreenn(
                  //                   allcartDataids:
                  //                       SpUtil.getString(SpConstUtil.cartID)!,
                  //                   title: '',
                  //                   toggleTheme: widget.toggleTheme,
                  //                 )));
                  //     setState(() {});
                  //   },
                  //   child: SpUtil.getDouble(SpConstUtil.totalqty) == 0.0
                  //       ? Image.asset(
                  //           "assets/png/grocery-store.png",
                  //           color: SpUtil.getBool(SpConstUtil.appTheme)!
                  //               ? colors.whitecolor
                  //               : colors.blackcolor,
                  //         )
                  //       : badges.Badge(
                  //           position: badges.BadgePosition.topEnd(
                  //             top: -7,
                  //             end: -5,
                  //           ),
                  //           badgeAnimation: const badges.BadgeAnimation.rotation(
                  //             animationDuration: Duration(seconds: 1),
                  //             colorChangeAnimationDuration: Duration(seconds: 1),
                  //             loopAnimation: false,
                  //             curve: Curves.fastOutSlowIn,
                  //             colorChangeAnimationCurve: Curves.easeInCubic,
                  //           ),
                  //           badgeContent: text(
                  //               "${SpUtil.getDouble(SpConstUtil.totalqty)!.toInt()}",
                  //               color: colors.whitecolor,
                  //               fontSize: 8),
                  //           child:
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreenn(
                                    allcartDataids:
                                        SpUtil.getString(SpConstUtil.cartID)!,
                                    title: '',
                                    toggleTheme: widget.toggleTheme,
                                  )));
                      setState(() {});
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
                      child: SpUtil.getDouble(SpConstUtil.totalqty) == 0.0
                          ? Padding(
                              padding: EdgeInsets.all(0.99.h),
                              child: Image.asset(
                                "assets/png/grocery-store.png",
                                color: SpUtil.getBool(SpConstUtil.appTheme)!
                                    ? colors.whitecolor
                                    : colors.blackcolor,
                              ),
                            )
                          : SpUtil.getString(SpConstUtil.cartID) == ""
                              ? Padding(
                                  padding: EdgeInsets.all(0.99.h),
                                  child: Image.asset(
                                    "assets/png/grocery-store.png",
                                    color: SpUtil.getBool(SpConstUtil.appTheme)!
                                        ? colors.whitecolor
                                        : colors.blackcolor,
                                  ),
                                )
                              : badges.Badge(
                                  position: badges.BadgePosition.topEnd(
                                    top: -7,
                                    end: -5,
                                  ),
                                  badgeAnimation:
                                      const badges.BadgeAnimation.rotation(
                                    animationDuration: Duration(seconds: 1),
                                    colorChangeAnimationDuration:
                                        Duration(seconds: 1),
                                    loopAnimation: false,
                                    curve: Curves.fastOutSlowIn,
                                    colorChangeAnimationCurve:
                                        Curves.easeInCubic,
                                  ),
                                  badgeContent: text(
                                      "${SpUtil.getDouble(SpConstUtil.totalqty)!.toInt()}",
                                      color: colors.whitecolor,
                                      fontSize: 8),
                                  child: Padding(
                                      padding: EdgeInsets.all(0.99.h),
                                      child: Image.asset(
                                        "assets/png/grocery-store.png",
                                        color: SpUtil.getBool(
                                                SpConstUtil.appTheme)!
                                            ? colors.whitecolor
                                            : colors.blackcolor,
                                      ))),
                    ),
                  ),

                  // ),
                  // )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    pageviewWidget(
                      pageController,
                      widget.data,
                      selectedImageIndex,
                      (index) {
                        setState(() {
                          selectedImageIndex = index;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    variantsListWidget(
                        pageController, widget.data, selectedImageIndex,
                        (index) {
                      setState(() {
                        selectedImageIndex = index;
                      });
                    }, scrollController, context),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: text(widget.data.name!,
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: text("\$${widget.data.price!}",
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              text("SKU: ",
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              text(
                                "${widget.data.sku![0].toUpperCase()}${widget.data.sku!.substring(1).toLowerCase()}",
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    quantityTableWidget(
                        colorLabels,
                        sizeLabels,
                        widget.data,
                        setState,
                        variantDataList,
                        _formKey,
                        pl,
                        qty,
                        controller,
                        context: context),
                    const SizedBox(
                      height: 10,
                    ),
                    sizeLabels.isEmpty
                        ? Container()
                        : addToCartButtonWidget(
                            variantDataList, pl, _formKey, setState),
                    const SizedBox(
                      height: 10,
                    ),
                    descriptionWidget(widget.data),
                    widget.screen == "scanner"
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text("You might also like",
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                    widget.screen == "scanner"
                        ? Container()
                        : widget.productsMainCategoryModel.data.isEmpty
                            ? Container()
                            : youMightAlsoLikeProductsWidget(
                                context,
                                widget.productsMainCategoryModel,
                                widget.data,
                                widget.toggleTheme,
                                setState)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
