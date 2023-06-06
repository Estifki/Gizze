// To parse this JSON data, do
//
//     final sandModel = sandModelFromJson(jsonString);

import 'package:meta/meta.dart';
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
    Sands sands;

    Data({
        required this.favorite,
        required this.sands,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        favorite: List<Favorite>.from(json["favorite"].map((x) => Favorite.fromJson(x))),
        sands: Sands.fromJson(json["sands"]),
    );

    Map<String, dynamic> toJson() => {
        "favorite": List<dynamic>.from(favorite.map((x) => x.toJson())),
        "sands": sands.toJson(),
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

class Sands {
    int currentPage;
    List<Favorite> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    Sands({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    factory Sands.fromJson(Map<String, dynamic> json) => Sands(
        currentPage: json["current_page"],
        data: List<Favorite>.from(json["data"].map((x) => Favorite.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Link {
    String url;
    String label;
    bool active;

    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
