// ignore_for_file: avoid_print

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/variant_data.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

GestureDetector addToCartButtonWidget(List<VariantData> variantDataList,
    ProgressLoader pl, GlobalKey<FormState> formKey, StateSetter setState) {
  return GestureDetector(
    onTap: () async {
      if (variantDataList.isEmpty) {
        await apis.showToast("please add atleast one product variant...");
      } else {
        if (formKey.currentState!.validate()) {
          List<Map<String, dynamic>> lineItems =
              variantDataList.map((variantData) {
            return {
              "quantity": variantData.quantity,
              "product_id": variantData.productId,
              "variant_id": variantData.variantId,
            };
          }).toList();

          if (SpUtil.getString(SpConstUtil.cartID) == "") {
            await pl.show();
            await apis.addToCartProductsApi(lineItems, pl, setState);
            await pl.hide();
          } else {
            await pl.show();

            await apis.addToCartNewApi(
                lineItems, SpUtil.getString(SpConstUtil.cartID)!, pl, setState);
            await pl.hide();
          }
        }
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.themebluecolor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: text("ADD TO CART",
              color: colors.whitecolor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )),
      ),
    ),
  );
}

GestureDetector addToCartButtonWidgetNew(
    var productId,
    int quantity,
    var variantId,
    ProgressLoader pl,
    GlobalKey<FormState> formKey,
    StateSetter setState) {
  return GestureDetector(
    onTap: () async {
      // if (formKey.currentState!.validate()) {
      // Construct lineItems
      List<Map<String, dynamic>> lineItems = [
        {
          "product_id": productId,
          "quantity": quantity,
          "variant_id": variantId,
        }
      ];

      if (SpUtil.getString(SpConstUtil.cartID) == "") {
        await pl.show();
        await apis.addToCartProductsApi(lineItems, pl, setState);
        await pl.hide();
      } else {
        await pl.show();
        await apis.addToCartNewApi(
            lineItems, SpUtil.getString(SpConstUtil.cartID)!, pl, setState);
        await pl.hide();
      }
      // }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.themebluecolor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "ADD TO CART",
              style: TextStyle(
                color: colors.whitecolor,
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

GestureDetector addToCartButtonTabletWidget(List<VariantData> variantDataList,
    ProgressLoader pl, GlobalKey<FormState> formKey, StateSetter setState) {
  return GestureDetector(
    onTap: () async {
      if (variantDataList.isEmpty) {
        await apis.showToast("please add atleast one product variant...");
      } else {
        if (formKey.currentState!.validate()) {
          List<Map<String, dynamic>> lineItems =
              variantDataList.map((variantData) {
            return {
              "quantity": variantData.quantity,
              "product_id": variantData.productId,
              "variant_id": variantData.variantId,
            };
          }).toList();

          if (SpUtil.getString(SpConstUtil.cartID) == "") {
            await pl.show();
            await apis.addToCartProductsApi(lineItems, pl, setState);
            await pl.hide();
          } else {
            await pl.show();

            await apis.addToCartNewApi(
                lineItems, SpUtil.getString(SpConstUtil.cartID)!, pl, setState);
            await pl.hide();
          }
        }
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.themebluecolor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: text("ADD TO CART",
              color: colors.whitecolor,
              fontSize: 8.sp,
              fontWeight: FontWeight.bold),
        )),
      ),
    ),
  );
}
