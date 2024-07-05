// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/add_cart_button_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/description_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/page_view_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_appbar.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/qty_table_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/variant_data.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/variants_list_widget.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/you_midht_also_like_product_widget.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetailTabletScreen extends StatefulWidget {
  var data;
  var productsMainCategoryModel;
  String screen;
  void Function() toggleTheme;

  ProductDetailTabletScreen(
      {super.key,
      required this.data,
      required this.productsMainCategoryModel,
      required this.screen,
      required this.toggleTheme});

  @override
  State<ProductDetailTabletScreen> createState() =>
      _ProductDetailTabletScreenState();
}

class _ProductDetailTabletScreenState extends State<ProductDetailTabletScreen> {
  int selectedImage = 0;
  List<String> sizeLabels = [];
  List<String> colorLabels = [];
  int qty = 0;

  List<VariantData> variantDataList = [];

  String? allcartDataid;
  int? qtyy;
  int selectedImageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
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
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      appBar: productDetailAppbar(context, widget.toggleTheme, setState),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pageviewTabletWidget(
                            pageController, widget.data, selectedImageIndex,
                            (index) {
                          setState(() {
                            selectedImageIndex = index;
                          });
                        }, context),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: variantsListWidget(
                              pageController, widget.data, selectedImageIndex,
                              (index) {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          }, scrollController, context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text(widget.data.name,
                              fontSize: 8.sp, fontWeight: FontWeight.bold),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: text(
                        //       "${widget.data.name![0].toUpperCase()}${widget.data.name.substring(1).toLowerCase()}",
                        //       fontSize: 8.sp,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text("\$${widget.data.price!}",
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              color: colors.blackcolor.withOpacity(0.4)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              text("SKU:",
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.normal),
                              text(" ${widget.data.sku!}",
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colors.themebluecolor),
                            ],
                          ),
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
                            : addToCartButtonTabletWidget(
                                variantDataList, pl, _formKey, setState),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            descriptionWidget(widget.data),
            widget.screen == "scanner"
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.h),
                      child: text("You might also like",
                          fontSize: 8.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
            widget.screen == "scanner"
                ? Container()
                : youMightAlsoLikeProductsTabletWidget(
                    context,
                    widget.productsMainCategoryModel,
                    widget.data,
                    widget.toggleTheme)
          ],
        ),
      ),
    );
  }
}
