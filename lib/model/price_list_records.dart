import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Datum>? data;
  Meta? meta;

  Welcome({
    this.data,
    this.meta,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  int? priceListId;
  int? variantId;
  int? price;
  double? salePrice;
  dynamic retailPrice;
  dynamic mapPrice;
  double? calculatedPrice;
  DateTime? dateCreated;
  DateTime? dateModified;
  String? currency;
  int? productId;
  List<dynamic>? bulkPricingTiers;
  String? sku;

  Datum({
    this.priceListId,
    this.variantId,
    this.price,
    this.salePrice,
    this.retailPrice,
    this.mapPrice,
    this.calculatedPrice,
    this.dateCreated,
    this.dateModified,
    this.currency,
    this.productId,
    this.bulkPricingTiers,
    this.sku,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        priceListId: json["price_list_id"],
        variantId: json["variant_id"],
        price: json["price"],
        salePrice: json["sale_price"]?.toDouble(),
        retailPrice: json["retail_price"],
        mapPrice: json["map_price"],
        calculatedPrice: json["calculated_price"]?.toDouble(),
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        currency: json["currency"],
        productId: json["product_id"],
        bulkPricingTiers: json["bulk_pricing_tiers"] == null
            ? []
            : List<dynamic>.from(json["bulk_pricing_tiers"]!.map((x) => x)),
        sku: json["sku"],
      );

  Map<String, dynamic> toJson() => {
        "price_list_id": priceListId,
        "variant_id": variantId,
        "price": price,
        "sale_price": salePrice,
        "retail_price": retailPrice,
        "map_price": mapPrice,
        "calculated_price": calculatedPrice,
        "date_created": dateCreated?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "currency": currency,
        "product_id": productId,
        "bulk_pricing_tiers": bulkPricingTiers == null
            ? []
            : List<dynamic>.from(bulkPricingTiers!.map((x) => x)),
        "sku": sku,
      };
}

class Meta {
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
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

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
