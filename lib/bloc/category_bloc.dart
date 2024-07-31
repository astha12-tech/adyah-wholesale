import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/category_model.dart';

class CategoryBloc {
  StreamController<CategoryModel> categorystreamController =
      StreamController.broadcast();
  Stream<CategoryModel> get categoryStream => categorystreamController.stream;
  CategoryModel? categoryModel;
  categoryBloc(ProgressLoader pl) async {
    categoryModel = await apis.categoryListApi(pl);
    categorystreamController.sink.add(categoryModel!);
  }
}

CategoryBloc categoryBloc = CategoryBloc();
