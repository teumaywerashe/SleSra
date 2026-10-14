import 'package:dio/dio.dart';
import 'package:silesra/Dataprovider/Models.dart';

class BaseService<T> {
  final String baseUrl;
  final Dio _dio = Dio();

  BaseService(this.baseUrl);

  Future<List> fetchAll(Function(Map<String, dynamic>) fromJson) async {
    try {
      print(" £££££££££ Fetch all is called here with $baseUrl");
      final response = await _dio.get(baseUrl);

      // Check if the response data contains 'result' key with a list
      if (response.data is Map && response.data['result'] is List) {
        List<dynamic> resultList = response.data['result'];
        return resultList.map((e) => fromJson(e)).toList();
      } else if (response.data is List) {
        // If 'result' doesn't exist, fallback to assuming the data is a list
        return (response.data as List).map((e) => fromJson(e)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }

  Future<T> fetchOne(String id, Function(Map<String, dynamic>) fromJson) async {
    final response = await _dio.get('$baseUrl/$id/');
    return fromJson(response.data);
  }

  Future<T> create(Map<String, dynamic> data,
      Function(Map<String, dynamic>) fromJson) async {
    print("!!!!! Called with $baseUrl" + " and data of $data");
    final response = await _dio.post(baseUrl, data: data);
    print("Get this response  $response");
    return fromJson(response.data);
  }

  Future<T> update(String id, Map<String, dynamic> data,
      Function(Map<String, dynamic>) fromJson) async {
    final response = await _dio.put('$baseUrl/$id/', data: data);
    return fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseUrl/$id/');
  }
}

class CarService extends BaseService<Car> {
  CarService() : super("http://188.245.105.29:8888/api/car/");

  Future<List> getCars() => fetchAll(Car.fromJson);
  Future<Car> getCar(String id) => fetchOne(id, Car.fromJson);
  Future<Car> addCar(Car car) => create(car.toJson(), Car.fromJson);
  Future<Car> updateCar(String id, Car car) =>
      update(id, car.toJson(), Car.fromJson);
}
