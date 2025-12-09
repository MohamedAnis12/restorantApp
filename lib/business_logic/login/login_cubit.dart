import 'package:craxe/business_logic/login/login_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/login_model.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postData(
        url: 'users/login',
        data: {'email': email, 'password': password},
      );
      print('--- LOGIN SUCCESS RAW RESPONSE ---');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      print('----------------------------------');
      LoginModel login = LoginModel.fromJson(response.data);
      if (login.token != null) {
        CasheHelper().saveData(key: 'userName', value: login.user?.name ?? '');
        CasheHelper().saveData(
          key: 'userEmail',
          value: login.user?.email ?? '',
        );
        CasheHelper().saveData(
          key: 'userImage',
          value: login.user?.image ?? '',
        );
        CasheHelper().saveData(
          key: 'TOKEN',
          value: login.token!,
        ); 
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
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else {
        errorMessage =
            e.message ?? 'Login failed due to an unknown server error.';
      }

      emit(LoginErrorState(errorMessage: errorMessage));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
