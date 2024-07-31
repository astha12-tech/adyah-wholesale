import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_customer_model.dart';

class GetCustomerBloc {
  StreamController<GetCustomerModel> getcustomerstreamController =
      StreamController.broadcast();
  Stream<GetCustomerModel> get getAllBrandscategoryStream =>
      getcustomerstreamController.stream;
  GetCustomerModel? getCustomerModel;
  getCustomerBloc(ProgressLoader pl) async {
    getCustomerModel = await apis.getCustomerApi(pl);
    getcustomerstreamController.sink.add(getCustomerModel!);
  }
}

GetCustomerBloc getCustomerBloc = GetCustomerBloc();
