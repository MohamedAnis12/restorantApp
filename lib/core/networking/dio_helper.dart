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
      ),
    );
  }

  // في ملف dio_helper.dart

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    // 💡 1. قراءة الـ Token
    String? token = CasheHelper().getData(key: 'TOKEN') as String?;

    
    return await dio.post(
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
    
  }
  // في ملف dio_helper.dart

  // في ملف dio_helper.dart، داخل دالة getData

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
    print('---------------------------');

    return await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}
