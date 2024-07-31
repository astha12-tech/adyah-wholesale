// ignore_for_file: avoid_print

import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/check_internet/check_internet.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/products_category_model.dart';
import 'package:flutter/cupertino.dart';

class FeaturedProductBloc {
  StreamController<ProductsMainCategoryModel> featuredproductsstreamController =
      StreamController.broadcast();
  Stream<ProductsMainCategoryModel> get featuredproductStream =>
      featuredproductsstreamController.stream;
  ProductsMainCategoryModel? parentCategoryModel;
  featuredproductsBloc(ProgressLoader pl, String url) async {
    parentCategoryModel = await apis.feauturedProductsApi(pl, 1, url);
    featuredproductsstreamController.sink.add(parentCategoryModel!);
  }

  Future<void> paginatedData(
      ProgressLoader pl, int nextPage, String url) async {
    debugPrint("==== paginatedData ===>");
    bool internet = await checkInternet();
    if (internet) {
      ProductsMainCategoryModel? temp =
          await apis.feauturedProductsApi(pl, nextPage, url);
      if (temp != null) {
        parentCategoryModel!.data!.addAll(temp.data!);
        featuredproductsstreamController.sink.add(parentCategoryModel!);
        commonData.isShow = false;
      } else {
        debugPrint("---------->temp.responseCode = not 200------>");

        commonData.isShow = false;
      }
    } else {
      commonData.isShow = false;

      debugPrint("Errorssss");
      featuredproductsstreamController.sink.addError(commonData.noInternet);
    }
  }
}

FeaturedProductBloc featuredProductBloc = FeaturedProductBloc();
