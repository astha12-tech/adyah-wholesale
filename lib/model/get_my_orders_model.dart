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
  String? message;
  Data? data;

  GetMyOrdersModel({
    this.code,
    this.message,
    this.data,
  });

  factory GetMyOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetMyOrdersModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<ListElement>? list;
  Paginator? paginator;

  Data({
    this.list,
    this.paginator,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
        paginator: json["paginator"] == null
            ? null
            : Paginator.fromJson(json["paginator"]),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "paginator": paginator?.toJson(),
      };
}

class ListElement {
  int? orderId;
  String? companyName;
  String? createdAt;
  String? updatedAt;
  int? isInvoiceOrder;
  dynamic channelId;
  String? channelName;
  String? orderStatus;
  String? totalIncTax;
  String? firstName;
  String? lastName;

  ListElement({
    this.orderId,
    this.companyName,
    this.createdAt,
    this.updatedAt,
    this.isInvoiceOrder,
    this.channelId,
    this.channelName,
    this.orderStatus,
    this.totalIncTax,
    this.firstName,
    this.lastName,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        orderId: json["orderId"],
        companyName: json["companyName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isInvoiceOrder: json["isInvoiceOrder"],
        channelId: json["channelId"],
        channelName: json["channelName"],
        orderStatus: json["orderStatus"],
        totalIncTax: json["totalIncTax"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "companyName": companyName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isInvoiceOrder": isInvoiceOrder,
        "channelId": channelId,
        "channelName": channelName,
        "orderStatus": orderStatus,
        "totalIncTax": totalIncTax,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class Paginator {
  int? totalCount;
  int? offset;
  int? limit;

  Paginator({
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
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
