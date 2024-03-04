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
   final SandType sandType;

  final LocationDetail location;

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
    required this.sandType,
  });

  factory SandLocation.fromJson(Map<String, dynamic> json) {
    return SandLocation(
      id: json['id'],
      sandId: json['sand_id'],
      locationId: json['location_id'] ?? "",
      userId: json['user_id'],
      price: json['price'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sand: Sand.fromJson(json['sand']),
      owner: Owner.fromJson(json['owner']),
             sandType: SandType.fromJson(json["sand_type"]),
 
      location: LocationDetail.fromJson(json['location']),
    );
  }
}

class SandType {
    final String id;
    final String name;
    final DateTime createdAt;
    final DateTime updatedAt;

    SandType({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SandType.fromJson(Map<String, dynamic> json) => SandType(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
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
  Deposit? deposit;
  Driver? driver;

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
    required this.driver,
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
        deposit:
            json["deposit"] != null ? Deposit.fromJson(json["deposit"]) : null,
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
      );
}

class Deposit {
  String id;
  String userId;
  String amount;
  dynamic reason;
  String status;
  String approvedBy;
  DateTime createdAt;
  DateTime updatedAt;

  Deposit({
    required this.id,
    required this.userId,
    required this.amount,
    required this.reason,
    required this.status,
    required this.approvedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"],
        reason: json["reason"],
        status: json["status"],
        approvedBy: json["approved_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "reason": reason,
        "status": status,
        "approved_by": approvedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Driver {
  String id;
  String userId;
  String locationId;
  DriverLocation location;
  String status;
  DateTime createdAt;
  List<String> carOwnershipDoc;
  List<String> licenceDoc;
  List<CarInformation> carInformation;
  dynamic account;

  Driver({
    required this.id,
    required this.userId,
    required this.locationId,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.carOwnershipDoc,
    required this.licenceDoc,
    required this.carInformation,
    required this.account,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        userId: json["user_id"],
        locationId: json["location_id"],
        location: DriverLocation.fromJson(json["location"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        carOwnershipDoc:
            List<String>.from(json["carOwnershipDoc"].map((x) => x)),
        licenceDoc: List<String>.from(json["LicenceDoc"].map((x) => x)),
        carInformation: List<CarInformation>.from(
            json["car_information"].map((x) => CarInformation.fromJson(x))),
        account: json["account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "location_id": locationId,
        "location": location.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "carOwnershipDoc": List<dynamic>.from(carOwnershipDoc.map((x) => x)),
        "LicenceDoc": List<dynamic>.from(licenceDoc.map((x) => x)),
        "car_information":
            List<dynamic>.from(carInformation.map((x) => x.toJson())),
        "account": account,
      };
}

class CarInformation {
  String id;
  String driverId;
  String plateNumber;
  String color;
  String loadCapacity;
  DateTime createdAt;
  DateTime updatedAt;

  CarInformation({
    required this.id,
    required this.driverId,
    required this.plateNumber,
    required this.color,
    required this.loadCapacity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarInformation.fromJson(Map<String, dynamic> json) => CarInformation(
        id: json["id"],
        driverId: json["driver_id"],
        plateNumber: json["plate_number"],
        color: json["color"],
        loadCapacity: json["load_capacity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "plate_number": plateNumber,
        "color": color,
        "load_capacity": loadCapacity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class DriverLocation {
  String locationName;
  String latitude;
  String longitude;

  DriverLocation({
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  factory DriverLocation.fromJson(Map<String, dynamic> json) => DriverLocation(
        locationName: json["location_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
        "latitude": latitude,
        "longitude": longitude,
      };
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

// class Location {
//   final String id;
//   final String name;
//   final LocationDetail locationDetail;
//   final String createdAt;
//   final String updatedAt;

//   Location({
//     required this.id,
//     required this.name,
//     required this.locationDetail,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       id: json['id']??"",
//       name: json['name']??"",
//       locationDetail: LocationDetail.fromJson(json['location']),
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

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
