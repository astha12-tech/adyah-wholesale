// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

List<HomeBannerModel> homeBannerModelFromJson(String str) => List<HomeBannerModel>.from(json.decode(str).map((x) => HomeBannerModel.fromJson(x)));

String homeBannerModelToJson(List<HomeBannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeBannerModel {
    String? id;
    String? bannerImage;

    HomeBannerModel({
        this.id,
        this.bannerImage,
    });

    factory HomeBannerModel.fromJson(Map<String, dynamic> json) => HomeBannerModel(
        id: json["ID"],
        bannerImage: json["banner_image"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "banner_image": bannerImage,
    };
}
