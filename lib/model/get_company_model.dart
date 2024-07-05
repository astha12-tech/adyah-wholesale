// To parse this JSON data, do
//
//     final getComapnyModel = getComapnyModelFromJson(jsonString);

import 'dart:convert';

GetComapnyModel getComapnyModelFromJson(String str) => GetComapnyModel.fromJson(json.decode(str));

String getComapnyModelToJson(GetComapnyModel data) => json.encode(data.toJson());

class GetComapnyModel {
    int? code;
    List<Datum>? data;
    Meta? meta;

    GetComapnyModel({
        this.code,
        this.data,
        this.meta,
    });

    factory GetComapnyModel.fromJson(Map<String, dynamic> json) => GetComapnyModel(
        code: json["code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? companyId;
    String? companyName;
    String? bcGroupName;
    int? companyStatus;
    int? catalogId;
    String? catalogName;
    String? companyEmail;
    String? companyPhone;
    String? addressLine1;
    String? addressLine2;
    String? city;
    String? state;
    String? country;
    String? zipCode;
    int? createdAt;
    int? updatedAt;
    String? uuid;
    List<dynamic>? priceListAssign;
    int? bcGroupId;

    Datum({
        this.companyId,
        this.companyName,
        this.bcGroupName,
        this.companyStatus,
        this.catalogId,
        this.catalogName,
        this.companyEmail,
        this.companyPhone,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.createdAt,
        this.updatedAt,
        this.uuid,
        this.priceListAssign,
        this.bcGroupId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyId: json["companyId"],
        companyName: json["companyName"],
        bcGroupName: json["bcGroupName"],
        companyStatus: json["companyStatus"],
        catalogId: json["catalogId"],
        catalogName: json["catalogName"],
        companyEmail: json["companyEmail"],
        companyPhone: json["companyPhone"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zipCode"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        uuid: json["uuid"],
        priceListAssign: json["priceListAssign"] == null ? [] : List<dynamic>.from(json["priceListAssign"]!.map((x) => x)),
        bcGroupId: json["bcGroupId"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "bcGroupName": bcGroupName,
        "companyStatus": companyStatus,
        "catalogId": catalogId,
        "catalogName": catalogName,
        "companyEmail": companyEmail,
        "companyPhone": companyPhone,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "state": state,
        "country": country,
        "zipCode": zipCode,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "uuid": uuid,
        "priceListAssign": priceListAssign == null ? [] : List<dynamic>.from(priceListAssign!.map((x) => x)),
        "bcGroupId": bcGroupId,
    };
}

class Meta {
    Pagination? pagination;
    String? message;

    Meta({
        this.pagination,
        this.message,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "message": message,
    };
}

class Pagination {
    int? totalCount;
    int? offset;
    int? limit;

    Pagination({
        this.totalCount,
        this.offset,
        this.limit,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["totalCount"],
        offset: json["offset"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "offset": offset,
        "limit": limit,
    };
}
