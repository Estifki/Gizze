// To parse this JSON data, do
//
//     final sandDetailsModel = sandDetailsModelFromJson(jsonString);

import 'dart:convert';

SandLocationModel sandLocationModelFromJson(String str) =>
    SandLocationModel.fromJson(json.decode(str));

String sandLocationModelToJson(SandLocationModel data) =>
    json.encode(data.toJson());

class SandLocationModel {
  bool success;
  String message;
  int status;
  List<SandLocationData> data;

  SandLocationModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory SandLocationModel.fromJson(Map<String, dynamic> json) =>
      SandLocationModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<SandLocationData>.from(
            json["sand_locations"].map((x) => SandLocationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SandLocationData {
  String id;
  String sandId;
  Location location;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  String locationId;
  Sand sand;
  Owner owner;

  SandLocationData({
    required this.id,
    required this.sandId,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.locationId,
    required this.sand,
    required this.owner,
  });

  factory SandLocationData.fromJson(Map<String, dynamic> json) =>
      SandLocationData(
        id: json["id"],
        sandId: json["sand_id"],
        location: Location.fromJson(json["location"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        locationId: json["location_id"],
        sand: Sand.fromJson(json["sand"]),
        owner: Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_id": sandId,
        "location": location.toJson(),
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "location_id": locationId,
        "sand": sand.toJson(),
        "owner": owner.toJson(),
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

class Owner {
  String id;
  OwnerName name;
  String phone;
  Email email;
  dynamic phoneVerifiedAt;
  dynamic twoFactorConfirmedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String roleId;
  String profilePhotoUrl;
  Role role;

  Owner({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.phoneVerifiedAt,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.roleId,
    required this.profilePhotoUrl,
    required this.role,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: ownerNameValues.map[json["name"]]!,
        phone: json["phone"],
        email: emailValues.map[json["email"]]!,
        phoneVerifiedAt: json["phone_verified_at"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        roleId: json["role_id"],
        profilePhotoUrl: json["profile_photo_url"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": ownerNameValues.reverse[name],
        "phone": phone,
        "email": emailValues.reverse[email],
        "phone_verified_at": phoneVerifiedAt,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "role_id": roleId,
        "profile_photo_url": profilePhotoUrl,
        "role": role.toJson(),
      };
}

enum Email { ADMIN_ADMIN_COM }

final emailValues = EnumValues({"admin@admin.com": Email.ADMIN_ADMIN_COM});

enum OwnerName { GIZE }

final ownerNameValues = EnumValues({"Gize": OwnerName.GIZE});

class Role {
  String id;
  RoleName name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: roleNameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": roleNameValues.reverse[name],
      };
}

enum RoleName { ADMIN }

final roleNameValues = EnumValues({"Admin": RoleName.ADMIN});

class Sand {
  String id;
  String name;
  String description;
  DateTime createdAt;
  String sandImage;

  Sand({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.sandImage,
  });

  factory Sand.fromJson(Map<String, dynamic> json) => Sand(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
