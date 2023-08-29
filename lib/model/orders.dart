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
  dynamic acceptedById;
  String orderedById;
  String orderNo;
  String amount;
  dynamic deposit;
  String totalPrice;
  dynamic additionalPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String orderStatusId;
  DatumDestinationLocation destinationLocation;
  OrderStatus orderStatus;
  SandLocation sandLocation;
  dynamic acceptedBy;
  OrderedBy orderedBy;

  OrderData({
    required this.id,
    required this.sandLocationId,
    required this.acceptedById,
    required this.orderedById,
    required this.orderNo,
    required this.amount,
    required this.deposit,
    required this.totalPrice,
    required this.additionalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderStatusId,
    required this.destinationLocation,
    required this.orderStatus,
    required this.sandLocation,
    required this.acceptedBy,
    required this.orderedBy,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        sandLocationId: json["sand_location_id"],
        acceptedById: json["accepted_by_id"],
        orderedById: json["ordered_by_id"],
        orderNo: json["order_no"],
        amount: json["amount"],
        deposit: json["deposit"],
        totalPrice: json["total_price"],
        additionalPrice: json["additional_price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderStatusId: json["order_status_id"],
        destinationLocation:
            DatumDestinationLocation.fromJson(json["destination_location"]),
        orderStatus: OrderStatus.fromJson(json["order_status"]),
        sandLocation: SandLocation.fromJson(json["sand_location"]),
        acceptedBy: json["accepted_by"],
        orderedBy: OrderedBy.fromJson(json["ordered_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sand_location_id": sandLocationId,
        "accepted_by_id": acceptedById,
        "ordered_by_id": orderedById,
        "order_no": orderNo,
        "amount": amount,
        "deposit": deposit,
        "total_price": totalPrice,
        "additional_price": additionalPrice,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_status_id": orderStatusId,
        "destination_location": destinationLocation.toJson(),
        "order_status": orderStatus.toJson(),
        "sand_location": sandLocation.toJson(),
        "accepted_by": acceptedBy,
        "ordered_by": orderedBy.toJson(),
      };
}

class DatumDestinationLocation {
  String locationName;
  double latitude;
  double longitude;

  DatumDestinationLocation({
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  factory DatumDestinationLocation.fromJson(Map<String, dynamic> json) =>
      DatumDestinationLocation(
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

class SandLocation {
  String id;
  String sandId;
  SandLocationDestinationLocation destinationLocation;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  dynamic locationId;
  Sand sand;
  OrderedBy owner;
  OrderStatus location;

  SandLocation({
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

  factory SandLocation.fromJson(Map<String, dynamic> json) => SandLocation(
        id: json["id"],
        sandId: json["sand_id"],
        destinationLocation: SandLocationDestinationLocation.fromJson(
            json["destination_location"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        locationId: json["location_id"],
        sand: Sand.fromJson(json["sand"]),
        owner: OrderedBy.fromJson(json["owner"]),
        location: json["location"] == null
            ? OrderStatus(
                id: "id",
                name: "Unknown",
                createdAt: DateTime.now(),
                updatedAt: DateTime.now())
            : OrderStatus.fromJson(json["location"]),
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
        "location": location.toJson(),
      };
}

class SandLocationDestinationLocation {
  double latitude;
  double longitude;

  SandLocationDestinationLocation({
    required this.latitude,
    required this.longitude,
  });

  factory SandLocationDestinationLocation.fromJson(Map<String, dynamic> json) =>
      SandLocationDestinationLocation(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
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
