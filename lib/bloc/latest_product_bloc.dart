import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/latest_product_model.dart';

class LatestProductBloc {
  StreamController<LatestProductModel> latestproductsstreamController =
      StreamController.broadcast();
  Stream<LatestProductModel> get latestproductStream =>
      latestproductsstreamController.stream;
  LatestProductModel? latestproductModel;
  latestproductsBloc(ProgressLoader pl) async {
    latestproductModel = await apis.latestProductsApi(pl);
    latestproductsstreamController.sink.add(latestproductModel!);
  }
}

LatestProductBloc latestProductBloc = LatestProductBloc();
