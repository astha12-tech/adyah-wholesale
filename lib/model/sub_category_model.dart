import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  Data? data;
  Meta? meta;

  SubCategoryModel({
    this.data,
    this.meta,
  });

  SubCategoryModel copyWith({
    Data? data,
    Meta? meta,
  }) =>
      SubCategoryModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Data {
  int? id;
  int? parentId;
  String? name;
  String? description;
  int? views;
  int? sortOrder;
  String? pageTitle;
  String? searchKeywords;
  List<dynamic>? metaKeywords;
  String? metaDescription;
  String? layoutFile;
  bool? isVisible;
  String? defaultProductSort;
  CustomUrl? customUrl;
  String? imageUrl;

  Data({
    this.id,
    this.parentId,
    this.name,
    this.description,
    this.views,
    this.sortOrder,
    this.pageTitle,
    this.searchKeywords,
    this.metaKeywords,
    this.metaDescription,
    this.layoutFile,
    this.isVisible,
    this.defaultProductSort,
    this.customUrl,
    this.imageUrl,
  });

  Data copyWith({
    int? id,
    int? parentId,
    String? name,
    String? description,
    int? views,
    int? sortOrder,
    String? pageTitle,
    String? searchKeywords,
    List<dynamic>? metaKeywords,
    String? metaDescription,
    String? layoutFile,
    bool? isVisible,
    String? defaultProductSort,
    CustomUrl? customUrl,
    String? imageUrl,
  }) =>
      Data(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        name: name ?? this.name,
        description: description ?? this.description,
        views: views ?? this.views,
        sortOrder: sortOrder ?? this.sortOrder,
        pageTitle: pageTitle ?? this.pageTitle,
        searchKeywords: searchKeywords ?? this.searchKeywords,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        layoutFile: layoutFile ?? this.layoutFile,
        isVisible: isVisible ?? this.isVisible,
        defaultProductSort: defaultProductSort ?? this.defaultProductSort,
        customUrl: customUrl ?? this.customUrl,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        description: json["description"],
        views: json["views"],
        sortOrder: json["sort_order"],
        pageTitle: json["page_title"],
        searchKeywords: json["search_keywords"],
        metaKeywords: json["meta_keywords"] == null
            ? []
            : List<dynamic>.from(json["meta_keywords"]!.map((x) => x)),
        metaDescription: json["meta_description"],
        layoutFile: json["layout_file"],
        isVisible: json["is_visible"],
        defaultProductSort: json["default_product_sort"],
        customUrl: json["custom_url"] == null
            ? null
            : CustomUrl.fromJson(json["custom_url"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "description": description,
        "views": views,
        "sort_order": sortOrder,
        "page_title": pageTitle,
        "search_keywords": searchKeywords,
        "meta_keywords": metaKeywords == null
            ? []
            : List<dynamic>.from(metaKeywords!.map((x) => x)),
        "meta_description": metaDescription,
        "layout_file": layoutFile,
        "is_visible": isVisible,
        "default_product_sort": defaultProductSort,
        "custom_url": customUrl?.toJson(),
        "image_url": imageUrl,
      };
}

class CustomUrl {
  String? url;
  bool? isCustomized;

  CustomUrl({
    this.url,
    this.isCustomized,
  });

  CustomUrl copyWith({
    String? url,
    bool? isCustomized,
  }) =>
      CustomUrl(
        url: url ?? this.url,
        isCustomized: isCustomized ?? this.isCustomized,
      );

  factory CustomUrl.fromJson(Map<String, dynamic> json) => CustomUrl(
        url: json["url"],
        isCustomized: json["is_customized"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "is_customized": isCustomized,
      };
}

class Meta {
  Meta(); // Constructor declaration

  Meta copyWith() => Meta(); // copyWith method

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(); // fromJson method

  Map<String, dynamic> toJson() => {}; // toJson method
}
