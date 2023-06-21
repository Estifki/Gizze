// To parse this JSON data, do
//
//     final sandDetailsModel = sandDetailsModelFromJson(jsonString);

import 'dart:convert';

SandDetailsModel sandDetailsModelFromJson(String str) => SandDetailsModel.fromJson(json.decode(str));

String sandDetailsModelToJson(SandDetailsModel data) => json.encode(data.toJson());

class SandDetailsModel {
    bool success;
    String message;
    int status;
    Data data;

    SandDetailsModel({
        required this.success,
        required this.message,
        required this.status,
        required this.data,
    });

    factory SandDetailsModel.fromJson(Map<String, dynamic> json) => SandDetailsModel(
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

class SandLocation {
    String id;
    String sandId;
    Location location;
    String price;
    DateTime createdAt;
    DateTime updatedAt;
    String userId;
    String locationId;
    Data sand;
    Owner owner;

    SandLocation({
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

    factory SandLocation.fromJson(Map<String, dynamic> json) => SandLocation(
        id: json["id"],
        sandId: json["sand_id"],
        location: Location.fromJson(json["location"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        locationId: json["location_id"],
        sand: Data.fromJson(json["sand"]),
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

class Data {
    String id;
    String name;
    String description;
    DateTime createdAt;
    String sandImage;
    List<SandLocation> sandLocations;

    Data({
        required this.id,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.sandImage,
        required this.sandLocations,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        sandImage: json["sand_image"],
        sandLocations: List<SandLocation>.from(json["sand_locations"].map((x) => SandLocation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "sand_image": sandImage,
        "sand_locations": List<dynamic>.from(sandLocations.map((x) => x.toJson())),
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
