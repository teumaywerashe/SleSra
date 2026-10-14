import 'dart:io';

import 'package:silesra/models/product_model.dart';

abstract class BaseListing {
  // final String? id;
  //final int city;
  //final int category;
  // final String approvalStatus;
  // final String paymentStatus;
  // final String? serviceFeeBank;
  // final String? feeReceiptImage;
  // final String? feeReceiptRefNumber;
  // final double? latitude;
  // final double? longitude;
  final String? phoneNumber;
  // final List<String>? images;

  // final DateTime created;
  // final DateTime updated;

  BaseListing({
    //required this.city,
    //required this.category,
    // required this.approvalStatus,
    // required this.paymentStatus,
    // this.serviceFeeBank,
    // this.feeReceiptImage,
    // this.feeReceiptRefNumber,
    // this.latitude,
    // this.longitude,
    this.phoneNumber,
    // this.images,
    // required this.created,
    // required this.updated,
  });

  Map<String, dynamic> toJson();
}

class Car extends BaseListing {
  final String sellOrRent;
  final CarMake carMake;
  final CarType carType;
  final Category category;

  // final Category category;
  final String transmission;
  final String fuelType;
  final double price;
  final String license;
  final int yearOfMake;
  final String model;
  final String mileage;
  final String description;

  Car({
    required this.sellOrRent,
    required this.carMake,
    required this.carType,
    required this.category,
    required this.transmission,
    required this.fuelType,
    required this.price, // Expecting double
    required this.license,
    required this.yearOfMake, // Expecting int
    required this.model,
    required this.mileage, // Expecting int
    required this.description,

    // required this.category,
  });

  // Factory method to create an instance from JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      sellOrRent: json['sell_or_rent'] ?? "",
      category: json['category'] != null
          ? Category.fromJson(json['category']) // Correctly parse the category
          : Category(id: 0, name: "Unknown"), // Fallback if category is null

      transmission: json['transmission'] ?? "",
      fuelType: json['fuelType'] ?? "",
      price: double.tryParse(json['price']?.toString() ?? '7.0') ?? 0.0,

      license: json['license'],
      yearOfMake: json['yearofMake'] ?? 0, // Ensure int
      model: json['model'] ?? "",
      mileage: json['mileage'] ?? 0, // Ensure int
      description: json['description'] ?? "",
      carMake: CarMake.fromJson(json['carMake'] ?? {}),
      carType: CarType.fromJson(json['carType'] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sell_or_rent': sellOrRent,
      'carMake': carMake.toJson(),
      'carType': carType.toJson(),
      'transmission': transmission,
      'fuelType': fuelType,

      'price': price, // Keep it as double
      'license': license,
      'yearofMake': yearOfMake, // Keep it as int
      'model': model,
      'category': category.toJson(),
      'mileage': mileage, // Keep it as int
      'description': description,
    };
  }
}

class House extends BaseListing {
  final String sellOrRent;
  final String houseType;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final String area;
  final double price;
  final String license;
  final String description;
  final Category category;
  final String? feeReciptImgpath; // Make it nullable

  House({
    required this.sellOrRent,
    required this.category,
    required this.houseType,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.area,
    required this.price,
    required this.license,
    this.feeReciptImgpath, // Make it optional
    required this.description,
    required super.phoneNumber,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      sellOrRent: json['sell_or_rent'] ?? "", // Default to empty string if null
      feeReciptImgpath: json['feeReciptImgpath'] ?? "",
      houseType: json['houseType'] ?? "", // Default to empty string if null
      numberOfBedrooms: json['numberOfBedrooms'] ?? 0, // Default to 0 if null
      numberOfBathrooms: json['numberofBathrooms'] ?? 0, // Default to 0 if null
      area: json['area'] ?? "", // Default to empty string if null
      price: double.tryParse(json['price']?.toString() ?? '0.0') ??
          0.0, // Default to 0.0 if null or invalid
      license: json['license'] ?? "", // Default to empty string if null
      description: json['description'] ?? "", // Default to empty string if null
      category: json['category'] != null
          ? Category.fromJson(
              json['category']) // Correctly parse the category if not null
          : Category(id: 0, name: "Unknown"), // Default category if null
      phoneNumber: json['phonenumber'] ?? "", // Default to empty string if null
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = {
      'sell_or_rent': sellOrRent,
      'houseType': houseType,
      'numberOfBedrooms': numberOfBedrooms,
      'numberOfBathrooms': numberOfBathrooms,
      'area': area,
      'price': price,
      'description': description,
      'feeReciptImgpath': feeReciptImgpath,
      'category': category.toJson(),
    };

    // Include feeReciptImage only if it's not null
    // if (feeReciptImage != null) {
    //   data['feeReciptImage'] = feeReciptImage?.path as Object;
    // }

    return data;
  }
}
