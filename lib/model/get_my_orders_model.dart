// // To parse this JSON data, do
// //
// //     final getMyOrdersModel = getMyOrdersModelFromJson(jsonString);

// import 'dart:convert';

// GetMyOrdersModel getMyOrdersModelFromJson(String str) =>
//     GetMyOrdersModel.fromJson(json.decode(str));

// String getMyOrdersModelToJson(GetMyOrdersModel data) =>
//     json.encode(data.toJson());

// class GetMyOrdersModel {
//   int? code;
//   String? message;
//   Data? data;

//   GetMyOrdersModel({
//     this.code,
//     this.message,
//     this.data,
//   });

//   factory GetMyOrdersModel.fromJson(Map<String, dynamic> json) =>
//       GetMyOrdersModel(
//         code: json["code"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   List<ListElement>? list;
//   Paginator? paginator;

//   Data({
//     this.list,
//     this.paginator,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         list: json["list"] == null
//             ? []
//             : List<ListElement>.from(
//                 json["list"]!.map((x) => ListElement.fromJson(x))),
//         paginator: json["paginator"] == null
//             ? null
//             : Paginator.fromJson(json["paginator"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "list": list == null
//             ? []
//             : List<dynamic>.from(list!.map((x) => x.toJson())),
//         "paginator": paginator?.toJson(),
//       };
// }

// class ListElement {
//   int? orderId;
//   String? companyName;
//   String? createdAt;
//   String? updatedAt;
//   int? isInvoiceOrder;
//   dynamic channelId;
//   String? channelName;
//   String? orderStatus;
//   String? totalIncTax;
//   String? firstName;
//   String? lastName;

//   ListElement({
//     this.orderId,
//     this.companyName,
//     this.createdAt,
//     this.updatedAt,
//     this.isInvoiceOrder,
//     this.channelId,
//     this.channelName,
//     this.orderStatus,
//     this.totalIncTax,
//     this.firstName,
//     this.lastName,
//   });

//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//         orderId: json["orderId"],
//         companyName: json["companyName"],
//         createdAt: json["createdAt"],
//         updatedAt: json["updatedAt"],
//         isInvoiceOrder: json["isInvoiceOrder"],
//         channelId: json["channelId"],
//         channelName: json["channelName"],
//         orderStatus: json["orderStatus"],
//         totalIncTax: json["totalIncTax"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "orderId": orderId,
//         "companyName": companyName,
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//         "isInvoiceOrder": isInvoiceOrder,
//         "channelId": channelId,
//         "channelName": channelName,
//         "orderStatus": orderStatus,
//         "totalIncTax": totalIncTax,
//         "firstName": firstName,
//         "lastName": lastName,
//       };
// }

// class Paginator {
//   int? totalCount;
//   int? offset;
//   int? limit;

//   Paginator({
//     this.totalCount,
//     this.offset,
//     this.limit,
//   });

//   factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
//         totalCount: json["totalCount"],
//         offset: json["offset"],
//         limit: json["limit"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "offset": offset,
//         "limit": limit,
//       };
// }
// To parse this JSON data, do
//
//     final getMyOrdersModel = getMyOrdersModelFromJson(jsonString);

import 'dart:convert';

GetMyOrdersModel getMyOrdersModelFromJson(String str) =>
    GetMyOrdersModel.fromJson(json.decode(str));

String getMyOrdersModelToJson(GetMyOrdersModel data) =>
    json.encode(data.toJson());

class GetMyOrdersModel {
  int? code;
  List<Datum>? data;
  Meta? meta;

  GetMyOrdersModel({
    this.code,
    this.data,
    this.meta,
  });

  factory GetMyOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetMyOrdersModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  int? id;
  String? bcOrderId;
  double? totalIncTax;
  dynamic poNumber;
  String? status;
  String? customStatus;
  dynamic cartId;
  int? items;
  double? usdIncTax;
  int? companyId;
  String? currencyCode;
  Money? money;
  int? statusCode;
  bool? isArchived;
  dynamic channelId;
  String? channelName;
  int? createdAt;
  int? updatedAt;

  Datum({
    this.id,
    this.bcOrderId,
    this.totalIncTax,
    this.poNumber,
    this.status,
    this.customStatus,
    this.cartId,
    this.items,
    this.usdIncTax,
    this.companyId,
    this.currencyCode,
    this.money,
    this.statusCode,
    this.isArchived,
    this.channelId,
    this.channelName,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bcOrderId: json["bcOrderId"],
        totalIncTax: json["totalIncTax"]?.toDouble(),
        poNumber: json["poNumber"],
        status: json["status"],
        customStatus: json["customStatus"],
        cartId: json["cartId"],
        items: json["items"],
        usdIncTax: json["usdIncTax"]?.toDouble(),
        companyId: json["companyId"],
        currencyCode: json["currencyCode"],
        money: json["money"] == null ? null : Money.fromJson(json["money"]),
        statusCode: json["statusCode"],
        isArchived: json["isArchived"],
        channelId: json["channelId"],
        channelName: json["channelName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bcOrderId": bcOrderId,
        "totalIncTax": totalIncTax,
        "poNumber": poNumber,
        "status": status,
        "customStatus": customStatus,
        "cartId": cartId,
        "items": items,
        "usdIncTax": usdIncTax,
        "companyId": companyId,
        "currencyCode": currencyCode,
        "money": money?.toJson(),
        "statusCode": statusCode,
        "isArchived": isArchived,
        "channelId": channelId,
        "channelName": channelName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Money {
  String? currencyLocation;
  String? currencyToken;
  String? decimalToken;
  int? decimalPlaces;
  String? thousandsToken;

  Money({
    this.currencyLocation,
    this.currencyToken,
    this.decimalToken,
    this.decimalPlaces,
    this.thousandsToken,
  });

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        currencyLocation: json["currencyLocation"],
        currencyToken: json["currencyToken"],
        decimalToken: json["decimalToken"],
        decimalPlaces: json["decimalPlaces"],
        thousandsToken: json["thousandsToken"],
      );

  Map<String, dynamic> toJson() => {
        "currencyLocation": currencyLocation,
        "currencyToken": currencyToken,
        "decimalToken": decimalToken,
        "decimalPlaces": decimalPlaces,
        "thousandsToken": thousandsToken,
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
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
