import 'dart:convert';

SandDetailsModel sandDetailsModelFromJson(String str) =>
    SandDetailsModel.fromJson(json.decode(str));

// String sandDetailsModelToJson(SandDetailsModel data) => json.encode(data.toJson());

class SandDetailsModel {
  final bool success;
  final String message;
  final int status;
  final SandData data;

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
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final dynamic categoryId;
  final String sandImage;
  final List<SandLocation> sandLocations;

  SandData({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.categoryId,
    required this.sandImage,
    required this.sandLocations,
  });

  factory SandData.fromJson(Map<String, dynamic> json) {
    List<SandLocation> sandLocations = [];
    if (json['sand_locations'] != null) {
      for (var locationJson in json['sand_locations']) {
        sandLocations.add(SandLocation.fromJson(locationJson));
      }
    }

    return SandData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'],
      categoryId: json['category_id'],
      sandImage: json['sand_image'],
      sandLocations: sandLocations,
    );
  }
}

class SandLocation {
  final String id;
  final String sandId;
  final String locationId;
  final String userId;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Sand sand;
  final Owner owner;
  final Location location;

  SandLocation({
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

  factory SandLocation.fromJson(Map<String, dynamic> json) {
    return SandLocation(
      id: json['id'],
      sandId: json['sand_id'],
      locationId: json['location_id'],
      userId: json['user_id'],
      price: json['price'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sand: Sand.fromJson(json['sand']),
      owner: Owner.fromJson(json['owner']),
      location: Location.fromJson(json['location']),
    );
  }
}

class Sand {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final dynamic categoryId;
  final dynamic sandImage;

  Sand({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.categoryId,
    required this.sandImage,
  });

  factory Sand.fromJson(Map<String, dynamic> json) {
    return Sand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'],
      categoryId: json['category_id'],
      sandImage: json['sand_image'],
    );
  }
}

class Owner {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String roleId;
  final String profilePhotoUrl;
  final Role role;
  final dynamic deposit;

  Owner({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.roleId,
    required this.profilePhotoUrl,
    required this.role,
    required this.deposit,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      roleId: json['role_id'],
      profilePhotoUrl: json['profile_photo_url'],
      role: Role.fromJson(json['role']),
      deposit: json['deposit'],
    );
  }
}

class Role {
  final String id;
  final String name;

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

class Location {
  final String id;
  final String name;
  final LocationDetail locationDetail;
  final String createdAt;
  final String updatedAt;

  Location({
    required this.id,
    required this.name,
    required this.locationDetail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      locationDetail: LocationDetail.fromJson(json['location']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LocationDetail {
  final double latitude;
  final double longitude;

  LocationDetail({
    required this.latitude,
    required this.longitude,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    return LocationDetail(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
