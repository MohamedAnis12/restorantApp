import 'package:craxe/helper/casheHelper.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        // هنا حط الرابط الأساسي بتاعك
        baseUrl: 'https://fci-se-project.vercel.app/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    // 💡 1. قراءة الـ Token
    String? token = CasheHelper().getData(key: 'TOKEN') as String?;

    final response = await dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          // 💡 2. إرسال الـ Authorization Header
          'Authorization': token != null ? 'Bearer $token' : null,
          'Content-Type': 'application/json',
        },
      ),
    );

    // 💡 طباعة الرد الخام للتحقق من النجاح الزائف
    print('--- POST REQUEST RAW RESPONSE ---');
    print('Status: ${response.statusCode}');
    print('Data: ${response.data}');
    print('---------------------------------');

    return response;
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    String? token = CasheHelper().getData(key: 'TOKEN') as String?;

    final headers = {
      'Authorization': token != null ? 'Bearer $token' : null,
      'Content-Type': 'application/json',
    };

    // 💡 أضف هذا السطر للتحقق مما سيتم إرساله بالضبط:
    print('--- SENDING GET REQUEST ---');
    print('URL: ${url}');
    print('Auth Header: ${headers['Authorization']}');

    return await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
  // في ملف dio_helper.dart

  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data, // لإرسال الـ ID في الـ Body
  }) async {
    String? token = CasheHelper().getData(key: 'TOKEN') as String?;

    final response = await dio.delete(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': token != null ? 'Bearer $token' : null,
          'Content-Type': 'application/json',
        },
      ),
    );

    print('--- DELETE REQUEST RAW RESPONSE ---');
    print('Status: ${response.statusCode}');
    print('Data: ${response.data}');
    print('-----------------------------------');

    return response;
  }
}
