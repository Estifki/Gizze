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
  Location location;
  DateTime createdAt;
  DateTime updatedAt;

  SandAddressData({
    required this.id,
    required this.name,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SandAddressData.fromJson(Map<String, dynamic> json) =>
      SandAddressData(
        id: json["id"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
