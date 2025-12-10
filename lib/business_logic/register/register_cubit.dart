import 'package:craxe/business_logic/register/register_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/RegisterModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart'; // تأكد من استيراد DioException

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> userRegister({
    required String name, 
    required String email,
    required String password,
    required String gender,
    required String image,
    required String phonenumber,
  })  async {
    // 💡 يجب إضافة async هنا
    emit(RegisterLoadingState());
    print('--- OUTGOING PAYLOAD DEBUG ---');
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Phone: $phonenumber');
    print('Gender: $gender');
    print('Image: $image');
    print('------------------------------');

    try {
      // 1. استخدام await للحصول على الرد مباشرة
      final response = await DioHelper.postData(
        url: 'users/add-user',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'gender': gender,
          'image': image,
          'phonenumber': phonenumber,
        },
      );

      // 2. طباعة الرد لمعرفة ما إذا كان فارغاً (لتصحيح خطأ التحليل)
      print('Raw Data: ${response.data}');
      print('Raw Status Code: ${response.statusCode}');

      // 3. التحليل وإصدار النجاح
      if (response.data != null && response.data.isNotEmpty) {
        // الرد يحتوي على بيانات (token + message)
        Registermodel register = Registermodel.fromJson(response.data);
        emit(RegisterSuccessState(registerModel: register));
      } else {
        // الرد فارغ (مثل 204 No Content) لكن العملية ناجحة
        emit(
          RegisterSuccessState(
            registerModel: Registermodel(message: 'User created successfully'),
          ),
        );
      }
    } on DioException catch (e) {
      // 4. معالجة أخطاء الشبكة والـ 400 الحقيقية

      // هذا سيطبع الرد الذي يرفضه السيرفر (إذا كان 400/404)
      print('--- DIO ERROR RESPONSE ---');
      print('Error Status: ${e.response?.statusCode}');
      print('Error Data: ${e.response?.data}');
      print('--------------------------');

      // إصدار حالة الفشل
      emit(
        RegisterFailureState(
          errorMessage:
              e.response?.data.toString() ?? e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      // 5. معالجة أخطاء التحليل (JSON Parsing Error)
      emit(
        RegisterFailureState(
          errorMessage: 'JSON Parsing Error: ${e.toString()}',
        ),
      );
    }
  }
}
