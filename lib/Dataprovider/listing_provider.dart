import 'package:flutter/material.dart';
import 'package:silesra/Dataprovider/BaseServiceProvider.dart';
import 'package:silesra/Dataprovider/Models.dart';
import 'package:silesra/config/settings.dart';

class ListingProvider with ChangeNotifier {
  final BaseService<Car> carService = CarService();
  final BaseService<House> houseService = BaseService<House>('$baseUrl/house/');

  Map<String, List<dynamic>> listings = {
    'car': [],
    'house': [],
    'job-vacancy': [],
    'other-item': [],
  };

  bool isLoading = false;

  Future<void> fetchListings(String category) async {
    try {
      isLoading = true;

      // Notify listeners after the current frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      List<dynamic> fetchedData;
      switch (category) {
        case 'car':
          fetchedData = await carService.fetchAll(Car.fromJson);
          break;
        case 'house':
          fetchedData = await houseService.fetchAll(House.fromJson);
          break;
        default:
          throw Exception('Invalid category: $category');
      }
      listings[category] = fetchedData;
    } catch (e) {
      print('Error fetching $category: $e');
    } finally {
      isLoading = false;

      // Ensure the UI is updated after async operation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> addListing(String category, dynamic data) async {
    try {
      switch (category) {
        case 'car':
          await carService.create(data.toJson(), Car.fromJson);
          break;
        case 'house':
          await houseService.create(data.toJson(), House.fromJson);
          break;
        default:
          throw Exception('Invalid category: $category');
      }
      await fetchListings(category);
    } catch (e) {
      print('Error adding $category: $e');
    }
  }

  Future<void> updateListing(String category, String id, dynamic data) async {
    try {
      switch (category) {
        case 'car':
          await carService.update(id, data.toJson(), Car.fromJson);
          break;
        case 'house':
          await houseService.update(id, data.toJson(), House.fromJson);
          break;
        default:
          throw Exception('Invalid category: $category');
      }
      await fetchListings(category);
    } catch (e) {
      print('Error updating $category: $e');
    }
  }

  Future<void> deleteListing(String category, String id) async {
    try {
      switch (category) {
        case 'car':
          await carService.delete(id);
          break;
        case 'house':
          await houseService.delete(id);
          break;
        default:
          throw Exception('Invalid category: $category');
      }
      await fetchListings(category);
    } catch (e) {
      print('Error deleting $category: $e');
    }
  }
}
