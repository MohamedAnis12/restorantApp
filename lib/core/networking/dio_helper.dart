import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        // هنا حط الرابط الأساسي بتاعك
        baseUrl: 'https://fci-se-project.vercel.app/', 
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}