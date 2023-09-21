// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  bool success;
  String message;
  int status;
  List<OrderData> data;

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
  String id;
  String sandLocationId;
  String orderedById;
  dynamic canceledById;
  String orderNo;
  dynamic additionalPrice;
  dynamic prePayment;
  dynamic transportPrice;
  DestinationLocation destinationLocation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String orderStatusId;
  dynamic totalPrice;
  dynamic totalAmount;
  OrderStatus orderStatus;
  SandLocation? sandLocation;
  dynamic acceptedBy;
  OrderedBy orderedBy;

  OrderData({
    required this.id,
    required this.sandLocationId,
    required this.orderedById,
    required this.canceledById,
    required this.orderNo,
    required this.additionalPrice,
    required this.prePayment,
    required this.transportPrice,
    required this.totalPrice,
    required this.destinationLocation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderStatusId,
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
        totalAmount: json["total_amount"],
        totalPrice: json["total"],
        orderStatus: OrderStatus.fromJson(json["order_status"]),
        sandLocation: json["sand_location"] != null
            ? SandLocation.fromJson(json["sand_location"])
            : null,
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
        "total_amount": totalAmount,
        "order_status": orderStatus.toJson(),
        "sand_location": sandLocation!.toJson(),
        "accepted_by": acceptedBy,
        "ordered_by": orderedBy.toJson(),
      };
}

class DestinationLocation {
  String locationName;
  double latitude;
  double longitude;

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
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Location? location;

  OrderStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        location: json["location"] != null
            ? Location.fromJson(json["location"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "location": location!.toJson(),
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

class OrderedBy {
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
  Deposit deposit;

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
      };
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

class SandLocation {
  String id;
  String sandId;
  String locationId;
  String userId;
  String price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Sand sand;
  OrderedBy owner;
  OrderStatus location;

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

  factory SandLocation.fromJson(Map<String, dynamic> json) => SandLocation(
        id: json["id"],
        sandId: json["sand_id"],
        locationId: json["location_id"],
        userId: json["user_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sand: Sand.fromJson(json["sand"]),
        owner: OrderedBy.fromJson(json["owner"]),
        location: OrderStatus.fromJson(json["location"]),
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
