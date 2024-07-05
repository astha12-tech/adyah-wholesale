// To parse this JSON data, do
//
//     final getAllBrandsModel = getAllBrandsModelFromJson(jsonString);

import 'dart:convert';

GetAllBrandsModel getAllBrandsModelFromJson(String str) => GetAllBrandsModel.fromJson(json.decode(str));

String getAllBrandsModelToJson(GetAllBrandsModel data) => json.encode(data.toJson());

class GetAllBrandsModel {
    List<Datum>? data;
    Meta? meta;

    GetAllBrandsModel({
        this.data,
        this.meta,
    });

    GetAllBrandsModel copyWith({
        List<Datum>? data,
        Meta? meta,
    }) => 
        GetAllBrandsModel(
            data: data ?? this.data,
            meta: meta ?? this.meta,
        );

    factory GetAllBrandsModel.fromJson(Map<String, dynamic> json) => GetAllBrandsModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? id;
    String? name;
    String? pageTitle;
    List<dynamic>? metaKeywords;
    String? metaDescription;
    String? imageUrl;
    String? searchKeywords;
    CustomUrl? customUrl;

    Datum({
        this.id,
        this.name,
        this.pageTitle,
        this.metaKeywords,
        this.metaDescription,
        this.imageUrl,
        this.searchKeywords,
        this.customUrl,
    });

    Datum copyWith({
        int? id,
        String? name,
        String? pageTitle,
        List<dynamic>? metaKeywords,
        String? metaDescription,
        String? imageUrl,
        String? searchKeywords,
        CustomUrl? customUrl,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            pageTitle: pageTitle ?? this.pageTitle,
            metaKeywords: metaKeywords ?? this.metaKeywords,
            metaDescription: metaDescription ?? this.metaDescription,
            imageUrl: imageUrl ?? this.imageUrl,
            searchKeywords: searchKeywords ?? this.searchKeywords,
            customUrl: customUrl ?? this.customUrl,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        pageTitle: json["page_title"],
        metaKeywords: json["meta_keywords"] == null ? [] : List<dynamic>.from(json["meta_keywords"]!.map((x) => x)),
        metaDescription: json["meta_description"],
        imageUrl: json["image_url"],
        searchKeywords: json["search_keywords"],
        customUrl: json["custom_url"] == null ? null : CustomUrl.fromJson(json["custom_url"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "page_title": pageTitle,
        "meta_keywords": metaKeywords == null ? [] : List<dynamic>.from(metaKeywords!.map((x) => x)),
        "meta_description": metaDescription,
        "image_url": imageUrl,
        "search_keywords": searchKeywords,
        "custom_url": customUrl?.toJson(),
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
    Pagination? pagination;

    Meta({
        this.pagination,
    });

    Meta copyWith({
        Pagination? pagination,
    }) => 
        Meta(
            pagination: pagination ?? this.pagination,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
    };
}

class Pagination {
    int? total;
    int? count;
    int? perPage;
    int? currentPage;
    int? totalPages;
    Links? links;

    Pagination({
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.links,
    });

    Pagination copyWith({
        int? total,
        int? count,
        int? perPage,
        int? currentPage,
        int? totalPages,
        Links? links,
    }) => 
        Pagination(
            total: total ?? this.total,
            count: count ?? this.count,
            perPage: perPage ?? this.perPage,
            currentPage: currentPage ?? this.currentPage,
            totalPages: totalPages ?? this.totalPages,
            links: links ?? this.links,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links?.toJson(),
    };
}

class Links {
    String? current;

    Links({
        this.current,
    });

    Links copyWith({
        String? current,
    }) => 
        Links(
            current: current ?? this.current,
        );

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        current: json["current"],
    );

    Map<String, dynamic> toJson() => {
        "current": current,
    };
}
