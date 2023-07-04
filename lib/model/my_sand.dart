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
  DestinationLocation destinationLocation;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  dynamic locationId;
  Sand sand;
  Owner owner;
  dynamic location;

  MySandData({
    required this.id,
    required this.sandId,
    required this.destinationLocation,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.locationId,
    required this.sand,
    required this.owner,
    required this.location,
  });

  factory MySandData.fromJson(Map<String, dynamic> json) => MySandData(
        id: json["id"],
        sandId: json["sand_id"],
        destinationLocation:
            DestinationLocation.fromJson(json["destination_location"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        locationId: json["location_id"],
        sand: Sand.fromJson(json["sand"]),
        owner: Owner.fromJson(json["owner"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_id": sandId,
        "destination_location": destinationLocation.toJson(),
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "location_id": locationId,
        "sand": sand.toJson(),
        "owner": owner.toJson(),
        "location": location,
      };
}

class DestinationLocation {
  double latitude;
  double longitude;

  DestinationLocation({
    required this.latitude,
    required this.longitude,
  });

  factory DestinationLocation.fromJson(Map<String, dynamic> json) =>
      DestinationLocation(
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
