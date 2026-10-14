import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define model classes
class CategoryHome {
  final String name;
  final String api;
  final IconData icon;
  final Color color;

  CategoryHome({
    required this.name,
    required this.api,
    required this.icon,
    required this.color,
  });
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // Factory constructor to create a Category from a JSON map
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  // Convert Category to a JSON map (for serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// SilesraBankAccount Model
class SilesraBankAccount {
  final int id;
  final String name;
  final String accountNumber;

  SilesraBankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
  });

  factory SilesraBankAccount.fromJson(Map<String, dynamic> json) {
    return SilesraBankAccount(
      id: json['id'],
      name: json['name'],
      accountNumber: json['account_number'],
    );
  }
}

// CustomerBank Model
class CustomerBank {
  final int id;
  final String name;

  CustomerBank({
    required this.id,
    required this.name,
  });

  factory CustomerBank.fromJson(Map<String, dynamic> json) {
    return CustomerBank(
      id: json['id'],
      name: json['name'],
    );
  }
}

// GeneralSetting Model
class GeneralSetting {
  final int id;
  final String serviceCallNumber;

  GeneralSetting({
    required this.id,
    required this.serviceCallNumber,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) {
    return GeneralSetting(
      id: json['id'],
      serviceCallNumber: json['service_call_number'],
    );
  }
}

// Category Model

// ServiceOrBusinessType Model
class ServiceOrBusinessType {
  final int id;
  final String name;

  ServiceOrBusinessType({
    required this.id,
    required this.name,
  });

  factory ServiceOrBusinessType.fromJson(Map<String, dynamic> json) {
    return ServiceOrBusinessType(
      id: json['id'],
      name: json['name'],
    );
  }
}

// CarMake Model

// CarType Model

// OtherItemCategory Model
class OtherItemCategory {
  final int id;
  final String name;

  OtherItemCategory({
    required this.id,
    required this.name,
  });

  factory OtherItemCategory.fromJson(Map<String, dynamic> json) {
    return OtherItemCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

// Service Fee Bank Model
class ServiceFeeBank {
  final int id;
  final String name;

  ServiceFeeBank({required this.id, required this.name});

  factory ServiceFeeBank.fromJson(Map<String, dynamic> json) {
    return ServiceFeeBank(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// Car Make Model
class CarMake {
  final int id;
  final String name;

  CarMake({required this.id, required this.name});

  factory CarMake.fromJson(Map<String, dynamic> json) {
    return CarMake(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// Car Type Model
class CarType {
  final int id;
  final String name;

  CarType({required this.id, required this.name});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Product {
  final int id;
  final String city;
  final String approvalStatus;
  final String paymentStatus;
  final String? feeReciptImage;
  final String feeReciptRefnumber;
  final String phonenumber;
  final String sellOrRent;
  final String transmission;
  final String fuelType;
  final double price; // Keeping as String to handle formatting in the UI
  final String license;
  final String model;
  final List<String> images;
  final String
      mileage; // Changed from `int` to `String` to avoid API inconsistencies
  final String description;
  final int yearofMake;
  final int category;
  final int carMake;

  Product({
    required this.id,
    required this.city,
    required this.approvalStatus,
    required this.paymentStatus,
    this.feeReciptImage,
    required this.feeReciptRefnumber,
    required this.phonenumber,
    required this.sellOrRent,
    required this.transmission,
    required this.fuelType,
    required this.price,
    required this.license,
    required this.model,
    required this.mileage,
    required this.images,
    required this.description,
    required this.yearofMake,
    required this.category,
    required this.carMake,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] ?? 0,
        city: json['city'] ?? '',
        approvalStatus: json['approvalStatus'] ?? '',
        paymentStatus: json['paymentStatus'] ?? '',
        feeReciptImage: json['feeReciptImage'],
        feeReciptRefnumber: json['feeReciptRefnumber'] ?? '',
        phonenumber: json['phonenumber'] ?? '',
        sellOrRent: json['sell_or_rent'] ?? '',
        transmission: json['transmission'] ?? '',
        fuelType: json['fuelType'] ?? '',
        price: json['price'] ?? '',
        license: json['license'] ?? '',
        model: json['model'] ?? '',
        mileage: json['mileage'] ?? '',
        description: json['description'] ?? '',
        yearofMake: json['yearofMake'] ?? 0,
        category: json['catagory'] ?? 0,
        carMake: json['carMake'] ?? 0,
        images: [
          'https://th.bing.com/th/id/OIP.O9nIGE4tMlRXgNs7GmFFLgHaE8?rs=1&pid=ImgDetMain',
          'https://th.bing.com/th/id/R.11f731bbd2873f053162c34fa8290fd5?rik=icVk0AJMp9oQzA&riu=http%3a%2f%2fmessagenote.com%2fwp-content%2fuploads%2f2011%2f04%2ftruscany-villa.jpg&ehk=8iTNr8kqps7FTKvrlSCs3v6i0TnlT538id7qzYuWQl0%3d&risl=&pid=ImgRaw&r=0'
        ],
      );
    } catch (e) {
      throw Exception('Error parsing product data: $e');
    }
  }
}

class ApiService {
  // Base URL for the API
  static const String baseUrl = 'http://188.245.105.29:8888/api/';

  // Fetch SilesraBankAccount data
  static Future<List<SilesraBankAccount>> fetchSilesraBankAccounts() async {
    final response = await http.get(Uri.parse('${baseUrl}silesrabankaccount/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => SilesraBankAccount.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load SilesraBankAccounts');
    }
  }

  // Fetch CustomerBank data
  static Future<List<CustomerBank>> fetchCustomerBanks() async {
    final response = await http.get(Uri.parse('${baseUrl}customerbank/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => CustomerBank.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load CustomerBanks');
    }
  }

  // Fetch GeneralSetting data
  static Future<List<GeneralSetting>> fetchGeneralSettings() async {
    final response = await http.get(Uri.parse('${baseUrl}generalsetting/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => GeneralSetting.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load GeneralSettings');
    }
  }

  // Fetch Category data
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}category/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  // Fetch ServiceOrBusinessType data
  static Future<List<ServiceOrBusinessType>>
      fetchServiceOrBusinessTypes() async {
    final response =
        await http.get(Uri.parse('${baseUrl}serviceorbussinesstypes/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ServiceOrBusinessType.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load ServiceOrBusinessTypes');
    }
  }

  // Fetch CarMake data
  static Future<List<CarMake>> fetchCarMakes() async {
    final response = await http.get(Uri.parse('${baseUrl}carmake/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => CarMake.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load CarMakes');
    }
  }

  // Fetch CarType data
  static Future<List<CarType>> fetchCarTypes() async {
    final response = await http.get(Uri.parse('${baseUrl}cartype/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => CarType.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load CarTypes');
    }
  }

  // Fetch OtherItemCategory data
  static Future<List<OtherItemCategory>> fetchOtherItemCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}otheritemcatagory/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => OtherItemCategory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load OtherItemCategories');
    }
  }

  static Future<List<Product>> fetchcars({
    List<Category>? selectedCategories,
    String searchQuery = '',
  }) async {
    try {
      final response =
          await http.get(Uri.parse('http://188.245.105.29:8888/api/car/'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> productsData = jsonData['result'];

        final products =
            productsData.map((item) => Product.fromJson(item)).toList();

        // Optional filtering logic
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(
    String category, {
    required String categoryName,
    String searchQuery = '',
  }) async {
    try {
      print('%%%%%%%% Searching for Catagory in the API  .....$category');
      final response = await http.get(
        Uri.parse('http://188.245.105.29:8888/api/$categoryName/'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Assuming the data structure contains a "result" key
        final List<dynamic> productsData = jsonData['result'];

        // Convert JSON data to a list of Product objects
        final products =
            productsData.map((item) => Product.fromJson(item)).toList();

        // Optional: Apply additional filtering based on searchQuery
        // if (searchQuery.isNotEmpty) {
        //   return products.where((product) {
        //     return product.name
        //         .toLowerCase()
        //         .contains(searchQuery.toLowerCase());
        //   }).toList();
        // }

        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
