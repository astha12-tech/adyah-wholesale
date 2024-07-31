import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/cart_data_model.dart';
import 'package:flutter/material.dart';

class CartDataBloc {
  StreamController<CartDataModel> cartDatastreamController =
      StreamController.broadcast();
  Stream<CartDataModel> get cartDataStream => cartDatastreamController.stream;
  CartDataModel? cartDataModel;
  cartDataBlocc(String cartID, ProgressLoader pl, StateSetter setState) async {
    cartDataModel = await apis.allCartDataApi(cartID, pl, setState);
    cartDatastreamController.sink.add(cartDataModel!);
  }

  void reload(String cartID, ProgressLoader pl, StateSetter setState) async {
    await cartDataBlocc(cartID, pl, setState);
  }
}

CartDataBloc cartDataBloc = CartDataBloc();
