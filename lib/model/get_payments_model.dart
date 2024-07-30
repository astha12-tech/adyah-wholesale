import 'dart:convert';

GetPaymentsModel getPaymentsModelFromJson(String str) =>
    GetPaymentsModel.fromJson(json.decode(str));

String getPaymentsModelToJson(GetPaymentsModel data) =>
    json.encode(data.toJson());

class GetPaymentsModel {
  List<Datum>? data;
  Meta? meta;

  GetPaymentsModel({
    this.data,
    this.meta,
  });

  factory GetPaymentsModel.fromJson(Map<String, dynamic> json) =>
      GetPaymentsModel(
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
  String? id;
  String? name;
  bool? testMode;
  String? type;
  List<SupportedInstrument>? supportedInstruments;
  List<dynamic>? storedInstruments;

  Datum({
    this.id,
    this.name,
    this.testMode,
    this.type,
    this.supportedInstruments,
    this.storedInstruments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        testMode: json["test_mode"],
        type: json["type"],
        supportedInstruments: json["supported_instruments"] == null
            ? []
            : List<SupportedInstrument>.from(json["supported_instruments"]!
                .map((x) => SupportedInstrument.fromJson(x))),
        storedInstruments: json["stored_instruments"] == null
            ? []
            : List<dynamic>.from(json["stored_instruments"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "test_mode": testMode,
        "type": type,
        "supported_instruments": supportedInstruments == null
            ? []
            : List<dynamic>.from(supportedInstruments!.map((x) => x.toJson())),
        "stored_instruments": storedInstruments == null
            ? []
            : List<dynamic>.from(storedInstruments!.map((x) => x)),
      };
}

class SupportedInstrument {
  String? instrumentType;
  bool? verificationValueRequired;

  SupportedInstrument({
    this.instrumentType,
    this.verificationValueRequired,
  });

  factory SupportedInstrument.fromJson(Map<String, dynamic> json) =>
      SupportedInstrument(
        instrumentType: json["instrument_type"],
        verificationValueRequired: json["verification_value_required"],
      );

  Map<String, dynamic> toJson() => {
        "instrument_type": instrumentType,
        "verification_value_required": verificationValueRequired,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
