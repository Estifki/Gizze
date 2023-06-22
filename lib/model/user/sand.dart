// To parse this JSON data, do
//
//     final sandModel = sandModelFromJson(jsonString);

import 'dart:convert';

SandModel sandModelFromJson(String str) => SandModel.fromJson(json.decode(str));

String sandModelToJson(SandModel data) => json.encode(data.toJson());

class SandModel {
    bool success;
    String message;
    int status;
    Data data;

    SandModel({
        required this.success,
        required this.message,
        required this.status,
        required this.data,
    });

    factory SandModel.fromJson(Map<String, dynamic> json) => SandModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    List<Favorite> favorite;
    List<Favorite> sands;

    Data({
        required this.favorite,
        required this.sands,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        favorite: List<Favorite>.from(json["favorite"].map((x) => Favorite.fromJson(x))),
        sands: List<Favorite>.from(json["sands"].map((x) => Favorite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "favorite": List<dynamic>.from(favorite.map((x) => x.toJson())),
        "sands": List<dynamic>.from(sands.map((x) => x.toJson())),
    };
}

class Favorite {
    String id;
    String name;
    String description;
    DateTime createdAt;
    String sandImage;

    Favorite({
        required this.id,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.sandImage,
    });

    factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        sandImage: json["sand_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "sand_image": sandImage,
    };
}
