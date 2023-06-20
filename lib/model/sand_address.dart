// To parse this JSON data, do
//
//     final sandAddressModel = sandAddressModelFromJson(jsonString);

import 'dart:convert';

SandAddressModel sandAddressModelFromJson(String str) =>
    SandAddressModel.fromJson(json.decode(str));

String sandAddressModelToJson(SandAddressModel data) =>
    json.encode(data.toJson());

class SandAddressModel {
  bool success;
  String message;
  int status;
  List<SandAddressData> data;

  SandAddressModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory SandAddressModel.fromJson(Map<String, dynamic> json) =>
      SandAddressModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<SandAddressData>.from(
            json["data"].map((x) => SandAddressData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SandAddressData {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  SandAddressData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SandAddressData.fromJson(Map<String, dynamic> json) =>
      SandAddressData(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
