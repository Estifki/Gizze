// To parse this JSON data, do
//
//     final sandModel = sandModelFromJson(jsonString);

import 'dart:convert';

SandModel sandModelFromJson(String str) => SandModel.fromJson(json.decode(str));

String sandModelToJson(SandModel data) => json.encode(data.toJson());

class SandModel {
  SandModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  bool success;
  dynamic message;
  int status;
  Data data;

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
  Data({
    required this.favorite,
    required this.sands,
  });

  List<Favorite> favorite;
  Sands sands;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        favorite: List<Favorite>.from(
            json["favorite"].map((x) => Favorite.fromJson(x))),
        sands: Sands.fromJson(json["sands"]),
      );

  Map<String, dynamic> toJson() => {
        "favorite": List<dynamic>.from(favorite.map((x) => x.toJson())),
        "sands": sands.toJson(),
      };
}

class Favorite {
  Favorite({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.sandImage,
  });

  dynamic id;
  dynamic name;
  dynamic description;
  Location location;
  dynamic price;
  DateTime createdAt;
  dynamic sandImage;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: Location.fromJson(json["location"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        sandImage: json["sand_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "location": location.toJson(),
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "sand_image": sandImage,
      };
}

class Location {
  Location({
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  dynamic locationName;
  dynamic latitude;
  dynamic longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Sands {
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

  int currentPage;
  List<Favorite> data;
  dynamic firstPageUrl;
  int from;
  int lastPage;
  dynamic lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  dynamic path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Sands.fromJson(Map<String, dynamic> json) => Sands(
        currentPage: json["current_page"],
        data:
            List<Favorite>.from(json["data"].map((x) => Favorite.fromJson(x))),
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
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  dynamic url;
  dynamic label;
  bool active;

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
