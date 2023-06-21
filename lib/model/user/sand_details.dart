import 'dart:convert';

SandDetailsModel sandDetailsModelFromJson(String str) =>
    SandDetailsModel.fromJson(json.decode(str));

class SandDetailsModel {
  bool success;
  String message;
  int status;
  SandData data;

  SandDetailsModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory SandDetailsModel.fromJson(Map<String, dynamic> json) {
    return SandDetailsModel(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: SandData.fromJson(json['data']),
    );
  }
}

class SandData {
  String id;
  String name;
  String description;
  DateTime createdAt;
  String sandImage;
  List<SandLocation> sandLocations;

  SandData({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.sandImage,
    required this.sandLocations,
  });

  factory SandData.fromJson(Map<String, dynamic> json) {
    return SandData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      sandImage: json['sand_image'],
      sandLocations: List<SandLocation>.from(json['sand_locations']
          .map((location) => SandLocation.fromJson(location))),
    );
  }
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
  Sand sand;
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

  factory SandLocation.fromJson(Map<String, dynamic> json) {
    return SandLocation(
      id: json['id'],
      sandId: json['sand_id'],
      location: Location.fromJson(json['location']),
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'],
      locationId: json['location_id'],
      sand: Sand.fromJson(json['sand']),
      owner: Owner.fromJson(json['owner']),
    );
  }
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
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

  factory Sand.fromJson(Map<String, dynamic> json) {
    return Sand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      sandImage: json['sand_image'],
    );
  }
}

class Owner {
  String id;
  String name;
  String phone;
  String email;
  DateTime? phoneVerifiedAt;
  DateTime? twoFactorConfirmedAt;
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
    this.phoneVerifiedAt,
    this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.roleId,
    required this.profilePhotoUrl,
    required this.role,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.parse(json['phone_verified_at'])
          : null,
      twoFactorConfirmedAt: json['two_factor_confirmed_at'] != null
          ? DateTime.parse(json['two_factor_confirmed_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
      roleId: json['role_id'],
      profilePhotoUrl: json['profile_photo_url'],
      role: Role.fromJson(json['role']),
    );
  }
}

class Role {
  String id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }
}
