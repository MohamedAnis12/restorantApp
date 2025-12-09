import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // مكتبة لطباعة الـ Logs بشكل جميل
import 'api_constants.dart';

class DioFactory {
  // نستخدم Private Constructor عشان نمنع إنشاء نسخ متعددة
  DioFactory._();

  static Dio? dio;

  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.baseUrl = ApiConstants.baseUrl
        ..options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
      
      addDioInterceptor();
    }
    return dio!;
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    
    // Interceptor لإضافة التوكن تلقائياً
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // هنا بتجيب التوكن من الـ Shared Preferences أو Secure Storage
          // String? token = await SharedPref.getToken();
          // if (token != null) {
          //   options.headers['Authorization'] = token;
          // }
          return handler.next(options);
        },
        onError: (error, handler) {
           // هنا ممكن تهندل لو التوكن انتهى وتعمل Logout
           return handler.next(error);
        }
      ),
    );
  }
}