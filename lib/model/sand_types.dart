// To parse this JSON data, do
//
//     final sandTypesModel = sandTypesModelFromJson(jsonString);

import 'dart:convert';

SandTypesModel sandTypesModelFromJson(String str) =>
    SandTypesModel.fromJson(json.decode(str));

String sandTypesModelToJson(SandTypesModel data) => json.encode(data.toJson());

class SandTypesModel {
  final bool success;
  final String message;
  final int status;
  final List<SandTypeData> data;

  SandTypesModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory SandTypesModel.fromJson(Map<String, dynamic> json) => SandTypesModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<SandTypeData>.from(
            json["data"].map((x) => SandTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SandTypeData {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  SandTypeData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SandTypeData.fromJson(Map<String, dynamic> json) => SandTypeData(
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
