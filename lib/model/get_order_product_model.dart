// To parse this JSON data, do
//
//     final geOrderProductsModel = geOrderProductsModelFromJson(jsonString);

import 'dart:convert';

GeOrderProductsModel geOrderProductsModelFromJson(String str) => GeOrderProductsModel.fromJson(json.decode(str));

String geOrderProductsModelToJson(GeOrderProductsModel data) => json.encode(data.toJson());

class GeOrderProductsModel {
    int? code;
    List<Datum>? data;
    Meta? meta;

    GeOrderProductsModel({
        this.code,
        this.data,
        this.meta,
    });

    factory GeOrderProductsModel.fromJson(Map<String, dynamic> json) => GeOrderProductsModel(
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
    int? id;
    int? productId;
    int? createdAt;
    int? updatedAt;
    String? productName;
    String? variantSku;
    int? variantId;
    String? productBrandName;
    int? quantity;
    List<Option>? options;

    Datum({
        this.id,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.productName,
        this.variantSku,
        this.variantId,
        this.productBrandName,
        this.quantity,
        this.options,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["productId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        productName: json["productName"],
        variantSku: json["variantSku"],
        variantId: json["variantId"],
        productBrandName: json["productBrandName"],
        quantity: json["quantity"],
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "productName": productName,
        "variantSku": variantSku,
        "variantId": variantId,
        "productBrandName": productBrandName,
        "quantity": quantity,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    };
}

class Option {
    int? id;
    int? optionId;
    int? orderProductId;
    int? productOptionId;
    String? displayName;
    String? displayNameCustomer;
    String? displayNameMerchant;
    String? displayValue;
    String? displayValueCustomer;
    String? displayValueMerchant;
    String? value;
    String? type;
    String? name;
    String? displayStyle;

    Option({
        this.id,
        this.optionId,
        this.orderProductId,
        this.productOptionId,
        this.displayName,
        this.displayNameCustomer,
        this.displayNameMerchant,
        this.displayValue,
        this.displayValueCustomer,
        this.displayValueMerchant,
        this.value,
        this.type,
        this.name,
        this.displayStyle,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionId: json["optionId"],
        orderProductId: json["orderProductId"],
        productOptionId: json["productOptionId"],
        displayName: json["displayName"],
        displayNameCustomer: json["displayNameCustomer"],
        displayNameMerchant: json["displayNameMerchant"],
        displayValue: json["displayValue"],
        displayValueCustomer: json["displayValueCustomer"],
        displayValueMerchant: json["displayValueMerchant"],
        value: json["value"],
        type: json["type"],
        name: json["name"],
        displayStyle: json["displayStyle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "optionId": optionId,
        "orderProductId": orderProductId,
        "productOptionId": productOptionId,
        "displayName": displayName,
        "displayNameCustomer": displayNameCustomer,
        "displayNameMerchant": displayNameMerchant,
        "displayValue": displayValue,
        "displayValueCustomer": displayValueCustomer,
        "displayValueMerchant": displayValueMerchant,
        "value": value,
        "type": type,
        "name": name,
        "displayStyle": displayStyle,
    };
}

class Meta {
    String? message;

    Meta({
        this.message,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
