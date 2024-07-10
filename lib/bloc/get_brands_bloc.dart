import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_all_brands_model.dart';

class GetBrandBloc {
  StreamController<GetAllBrandsModel> getbrandstreamController =
      StreamController.broadcast();
  Stream<GetAllBrandsModel> get getAllBrandscategoryStream =>
      getbrandstreamController.stream;
  GetAllBrandsModel? getAllBrandsModel;
  getBrandsBloc(ProgressLoader pl) async {
    getAllBrandsModel = await apis.getAllBrandsApi(pl);
    getbrandstreamController.sink.add(getAllBrandsModel!);
  }
}

GetBrandBloc getBrandBloc = GetBrandBloc();
