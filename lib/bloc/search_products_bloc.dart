// ignore_for_file: avoid_print

import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/check_internet/check_internet.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/products_category_model.dart';
import 'package:flutter/cupertino.dart';

class SearchProductBloc {
  StreamController<ProductsMainCategoryModel> searchproductsstreamController =
      StreamController.broadcast();
  Stream<ProductsMainCategoryModel> get searchproductStream =>
      searchproductsstreamController.stream;
  ProductsMainCategoryModel? parentCategoryModel;
  searchproductsBloc(ProgressLoader pl, String searchkeyword) async {
    parentCategoryModel = await apis.searchProductsApi(pl, 1, searchkeyword);
    searchproductsstreamController.sink.add(parentCategoryModel!);
  }

  Future<void> paginatedData(
      ProgressLoader pl, int nextPage, String searchkeyword) async {
    debugPrint("==== paginatedData ===>");
    bool internet = await checkInternet();
    if (internet) {
      ProductsMainCategoryModel? temp =
          await apis.searchProductsApi(pl, nextPage, searchkeyword);
      if (temp != null) {
        parentCategoryModel!.data!.addAll(temp.data!);
        searchproductsstreamController.sink.add(parentCategoryModel!);
        commonData.isShow = false;
      } else {
        debugPrint("<-------temp.responseCode = not 200------>");

        commonData.isShow = false;
      }
    } else {
      commonData.isShow = false;

      debugPrint("Errorssss");
      searchproductsstreamController.sink.addError(commonData.noInternet);
    }
  }
}

SearchProductBloc searchProductBloc = SearchProductBloc();
