// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool success;
    String message;
    int status;
    ProfileData data;

    ProfileModel({
        required this.success,
        required this.message,
        required this.status,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": data.toJson(),
    };
}

class ProfileData {
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

    ProfileData({
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

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
