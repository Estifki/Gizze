// To parse this JSON data, do
//
//     final paymentMethodesModel = paymentMethodesModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodesModel paymentMethodesModelFromJson(String str) => PaymentMethodesModel.fromJson(json.decode(str));

String paymentMethodesModelToJson(PaymentMethodesModel data) => json.encode(data.toJson());

class PaymentMethodesModel {
    bool success;
    String message;
    int status;
    List<PaymentMethod> data;

    PaymentMethodesModel({
        required this.success,
        required this.message,
        required this.status,
        required this.data,
    });

    factory PaymentMethodesModel.fromJson(Map<String, dynamic> json) => PaymentMethodesModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        data: List<PaymentMethod>.from(json["data"].map((x) => PaymentMethod.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class PaymentMethod {
    String id;
    String name;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    Account account;

    PaymentMethod({
        required this.id,
        required this.name,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.account,
    });

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        account: Account.fromJson(json["account"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "account": account.toJson(),
    };
}

class Account {
    String id;
    String paymentMethodId;
    String accountName;
    String accountType;
    String accountNumber;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    Account({
        required this.id,
        required this.paymentMethodId,
        required this.accountName,
        required this.accountType,
        required this.accountNumber,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        paymentMethodId: json["payment_method_id"],
        accountName: json["account_name"],
        accountType: json["account_type"],
        accountNumber: json["account_number"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method_id": paymentMethodId,
        "account_name": accountName,
        "account_type": accountType,
        "account_number": accountNumber,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
