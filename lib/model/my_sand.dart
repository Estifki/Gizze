// To parse this JSON data, do
//
//     final mySandModel = mySandModelFromJson(jsonString);

import 'dart:convert';

MySandModel mySandModelFromJson(String str) =>
    MySandModel.fromJson(json.decode(str));

String mySandModelToJson(MySandModel data) => json.encode(data.toJson());

class MySandModel {
  bool success;
  String message;
  int status;
  List<MySandData> data;

  MySandModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory MySandModel.fromJson(Map<String, dynamic> json) => MySandModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<MySandData>.from(
            json["data"].map((x) => MySandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MySandData {
  String id;
  String sandId;
  String locationId;
  String userId;
  String price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Sand sand;
  Owner owner;
  DatumLocation location;

  MySandData({
    required this.id,
    required this.sandId,
    required this.locationId,
    required this.userId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sand,
    required this.owner,
    required this.location,
  });

  factory MySandData.fromJson(Map<String, dynamic> json) => MySandData(
        id: json["id"],
        sandId: json["sand_id"],
        locationId: json["location_id"],
        userId: json["user_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sand: Sand.fromJson(json["sand"]),
        owner: Owner.fromJson(json["owner"]),
        location: DatumLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_id": sandId,
        "location_id": locationId,
        "user_id": userId,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sand": sand.toJson(),
        "owner": owner.toJson(),
        "location": location.toJson(),
      };
}

class DatumLocation {
  String id;
  String name;
  LocationLocation location;
  DateTime createdAt;
  DateTime updatedAt;

  DatumLocation({
    required this.id,
    required this.name,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatumLocation.fromJson(Map<String, dynamic> json) => DatumLocation(
        id: json["id"],
        name: json["name"],
        location: LocationLocation.fromJson(json["location"]),
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

class LocationLocation {
  double latitude;
  double longitude;

  LocationLocation({
    required this.latitude,
    required this.longitude,
  });

  factory LocationLocation.fromJson(Map<String, dynamic> json) =>
      LocationLocation(
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
  String name;
  String phone;
  String email;
  dynamic phoneVerifiedAt;
  dynamic twoFactorConfirmedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String roleId;
  String profilePhotoUrl;
  Role role;
  dynamic deposit;

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
    required this.deposit,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        phoneVerifiedAt: json["phone_verified_at"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        roleId: json["role_id"],
        profilePhotoUrl: json["profile_photo_url"],
        role: Role.fromJson(json["role"]),
        deposit: json["deposit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "phone_verified_at": phoneVerifiedAt,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "role_id": roleId,
        "profile_photo_url": profilePhotoUrl,
        "role": role.toJson(),
        "deposit": deposit,
      };
}

class Role {
  String id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Sand {
  String id;
  String name;
  String description;
  DateTime createdAt;
  dynamic categoryId;
  String sandImage;

  Sand({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.categoryId,
    required this.sandImage,
  });

  factory Sand.fromJson(Map<String, dynamic> json) => Sand(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        categoryId: json["category_id"],
        sandImage: json["sand_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "category_id": categoryId,
        "sand_image": sandImage,
      };
}
