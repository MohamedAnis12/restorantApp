import 'package:craxe/business_logic/login/login_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/login_model.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  // في ملف login_cubit.dart

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    // 💡 يجب إضافة async
    emit(LoginLoadingState());

    try {
      final response = await DioHelper.postData(
        url: 'users/login', // أو المسار الصحيح للدخول
        data: {'email': email, 'password': password},
      );
      print('--- LOGIN SUCCESS RAW RESPONSE ---');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      print('----------------------------------');
      // 💡 التحليل والحفظ عند النجاح
      LoginModel login = LoginModel.fromJson(response.data);
      if (login.token != null) {
        CasheHelper().saveData(key: 'TOKEN', value: login.token!);
        // 💡 الانتقال إلى الشاشة الرئيسية بعد الحفظ
        Get.offAllNamed('/home');
      }

      emit(LoginSuccessState(loginModel: login));
    } on DioException catch (e) {
      String errorMessage;
      final responseData = e.response?.data;
      print('--- LOGIN FAILURE RAW RESPONSE ---');
      print('Status: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('----------------------------------');
      // 💡 التحقق مما إذا كان الرد هو Map يحتوي على مفتاح 'message'
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else {
        // إذا كان الرد ليس Map، أو كان نصًا خامًا، نستخدم رسالة Dio الافتراضية
        errorMessage =
            e.message ?? 'Login failed due to an unknown server error.';
      }

      emit(LoginErrorState(errorMessage: errorMessage));
    } catch (e) {
      // معالجة أخطاء التحليل الأخرى
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
