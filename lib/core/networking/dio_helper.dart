import 'package:dio/dio.dart';
import 'dio_factory.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // GET Request
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.get(
      endPoint,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // POST Request
  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // PUT Request (للتعديل)
  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.put(
      endPoint,
      data: data,
    );
    return response.data;
  }

  // DELETE Request
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    var response = await _dio.delete(
      endPoint,
      data: data,
    );
    return response.data;
  }
}