import 'dart:convert';

PriceListModel priceListModelFromJson(String str) =>
    PriceListModel.fromJson(json.decode(str));

String priceListModelToJson(PriceListModel data) => json.encode(data.toJson());

class PriceListModel {
  String? pricelist;
  String? imgurl;

  PriceListModel({
    this.pricelist,
    this.imgurl,
  });

  factory PriceListModel.fromJson(Map<String, dynamic> json) => PriceListModel(
        pricelist: json["pricelist"],
        imgurl: json["imgurl"],
      );

  Map<String, dynamic> toJson() => {
        "pricelist": pricelist,
        "imgurl": imgurl,
      };
}
