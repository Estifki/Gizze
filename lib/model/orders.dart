// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  final bool success;
  final String message;
  final int status;
  final List<OrderData> data;

  OrdersModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  final String id;
  final String sandLocationId;
  final String orderedById;
  final dynamic canceledById;
  final String orderNo;
  final String additionalPrice;
  final String prePayment;
  final String transportPrice;
  final DestinationLocation destinationLocation;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderStatusId;
  final String total;
  final double totalAmount;
  final OrderStatus orderStatus;
  final SandLocation sandLocation;
  final dynamic acceptedBy;
  final OrderedBy orderedBy;

  OrderData({
    required this.id,
    required this.sandLocationId,
    required this.orderedById,
    required this.canceledById,
    required this.orderNo,
    required this.additionalPrice,
    required this.prePayment,
    required this.transportPrice,
    required this.destinationLocation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderStatusId,
    required this.total,
    required this.totalAmount,
    required this.orderStatus,
    required this.sandLocation,
    required this.acceptedBy,
    required this.orderedBy,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        sandLocationId: json["sand_location_id"],
        orderedById: json["ordered_by_id"],
        canceledById: json["canceled_by_id"],
        orderNo: json["order_no"],
        additionalPrice: json["additional_price"],
        prePayment: json["pre_payment"],
        transportPrice: json["transport_price"],
        destinationLocation:
            DestinationLocation.fromJson(json["destination_location"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderStatusId: json["order_status_id"],
        total: json["total"],
        totalAmount: json["total_amount"]?.toDouble(),
        orderStatus: OrderStatus.fromJson(json["order_status"]),
        sandLocation: SandLocation.fromJson(json["sand_location"]),
        acceptedBy: json["accepted_by"],
        orderedBy: OrderedBy.fromJson(json["ordered_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_location_id": sandLocationId,
        "ordered_by_id": orderedById,
        "canceled_by_id": canceledById,
        "order_no": orderNo,
        "additional_price": additionalPrice,
        "pre_payment": prePayment,
        "transport_price": transportPrice,
        "destination_location": destinationLocation.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_status_id": orderStatusId,
        "total": total,
        "total_amount": totalAmount,
        "order_status": orderStatus.toJson(),
        "sand_location": sandLocation.toJson(),
        "accepted_by": acceptedBy,
        "ordered_by": orderedBy.toJson(),
      };
}

class DestinationLocation {
  final String locationName;
  final double latitude;
  final double longitude;

  DestinationLocation({
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  factory DestinationLocation.fromJson(Map<String, dynamic> json) =>
      DestinationLocation(
        locationName: json["location_name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderStatus {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
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

class OrderedBy {
  final String id;
  final String name;
  final String phone;
  final String email;
  final dynamic phoneVerifiedAt;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String roleId;
  final String profilePhotoUrl;
  final Role role;
  final Deposit deposit;
  // final Driver driver;

  OrderedBy({
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
    // required this.driver,
  });

  factory OrderedBy.fromJson(Map<String, dynamic> json) => OrderedBy(
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
        deposit: Deposit.fromJson(json["deposit"]),
        // driver: Driver.fromJson(json["driver"]),
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
        "deposit": deposit.toJson(),
        // "driver": driver.toJson(),
      };
}

class Deposit {
  final String id;
  final String userId;
  final String amount;
  final dynamic reason;
  final String status;
  final String approvedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  final String id;
  final String userId;
  final String locationId;
  final DriverLocation location;
  final String status;
  final DateTime createdAt;
  final List<String> carOwnershipDoc;
  final List<String> licenceDoc;
  final List<CarInformation> carInformation;
  final dynamic account;

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
  final String id;
  final String driverId;
  final String plateNumber;
  final String color;
  final String loadCapacity;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  final String locationName;
  final String latitude;
  final String longitude;

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

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SandLocation {
  final String id;
  final String sandId;
  final String userId;
  final String price;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sandTypeId;
  final SandLocationLocation location;
  final Sand sand;
  final OrderedBy owner;
  final OrderStatus sandType;

  SandLocation({
    required this.id,
    required this.sandId,
    required this.userId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sandTypeId,
    required this.location,
    required this.sand,
    required this.owner,
    required this.sandType,
  });

  factory SandLocation.fromJson(Map<String, dynamic> json) => SandLocation(
        id: json["id"],
        sandId: json["sand_id"],
        userId: json["user_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sandTypeId: json["sand_type_id"],
        location: SandLocationLocation.fromJson(json["location"]),
        sand: Sand.fromJson(json["sand"]),
        owner: OrderedBy.fromJson(json["owner"]),
        sandType: OrderStatus.fromJson(json["sand_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_id": sandId,
        "user_id": userId,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sand_type_id": sandTypeId,
        "location": location.toJson(),
        "sand": sand.toJson(),
        "owner": owner.toJson(),
        "sand_type": sandType.toJson(),
      };
}

class SandLocationLocation {
  final double latitude;
  final double longitude;

  SandLocationLocation({
    required this.latitude,
    required this.longitude,
  });

  factory SandLocationLocation.fromJson(Map<String, dynamic> json) =>
      SandLocationLocation(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Sand {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final dynamic categoryId;
  final String sandImage;

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
