import 'package:flutter/material.dart';

class AppAssets {}

class AppColor {
  static const Color primaryColor = Color(0xffde7c1e);
}

class AppConst {
  static const String AppUrl = "https://gize.amanueld.info/api";
}

class ProductM {
  String name;
  String description;
  String address;
  double price;
  String imageUrl;

  ProductM(
      {required this.name,
      required this.address,
      required this.price,
      required this.description,
      required this.imageUrl});
}

List<ProductM> data = [
  ProductM(
      name: "Arsi Sand",
      address: "Goro",
      price: 2000,
      description:
          "is simply dummy text of the printing and type Lorem setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg1.png"),
  ProductM(
      name: "Alage Sand",
      address: "Unisa",
      price: 1800,
      description:
          "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg2.png"),
  ProductM(
      name: "Metehara Sand",
      address: "Goro",
      price: 800,
      description:
          "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg3.png"),
  ProductM(
      name: "Arsi Sand",
      address: "Goro",
      price: 2000,
      description:
          "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg1.png"),
  ProductM(
      name: "Alage Sand",
      address: "Unisa",
      price: 1800,
      description:
          "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg2.png"),
  ProductM(
      name: "Metehara Sand",
      address: "Goro",
      price: 800,
      description:
          "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy",
      imageUrl: "assets/pngimg3.png"),
];

class AppRoute {
  static const String home = "/home";
  static const String newPassword = "/newPassword";

  static const String registerScreen = "/registerScreen";
}
