// To parse this JSON data, do
//
//     final addres = addresFromJson(jsonString);

import 'dart:convert';

Addres addresFromJson(String str) => Addres.fromJson(json.decode(str));

String addresToJson(Addres data) => json.encode(data.toJson());

class Addres {
  Addres({
    this.httpStatus,
    this.httpStatusCode,
    this.success,
    this.message,
    this.apiName,
    this.data,
  });

  String? httpStatus;
  int? httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  List<Datum>? data;

  factory Addres.fromJson(Map<String, dynamic> json) => Addres(
    httpStatus: json["httpStatus"],
    httpStatusCode: json["httpStatusCode"],
    success: json["success"],
    message: json["message"],
    apiName: json["apiName"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "httpStatus": httpStatus,
    "httpStatusCode": httpStatusCode,
    "success": success,
    "message": message,
    "apiName": apiName,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.placeName,
    this.placeId,
  });

  String? placeName;
  String? placeId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    placeName: json["placeName"],
    placeId: json["placeId"],
  );

  Map<String, dynamic> toJson() => {
    "placeName": placeName,
    "placeId": placeId,
  };
}
