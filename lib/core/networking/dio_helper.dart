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

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.post(url, data: data, queryParameters: query);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query, // لمتغيرات الـ Query Parameters الاختيارية
  }) async {
    // 💡 1. قراءة الـ Token المحفوظ
    // يجب عليك التأكد من أن الـ CasheHelper().getData قد تم تعديله لاستقبال key:
    String? token = CasheHelper().getData(key: 'TOKEN') as String?;

    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          // 💡 2. إرسال الـ Authorization Header (Bearer Token)
          'Authorization': token != null ? 'Bearer $token' : null,
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
