import 'package:craxe/business_logic/login/login_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(super.initialState);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    DioHelper.postData(url: 'url', data: {'email': email, 'password': password})
        .then((value) {
          LoginModel login = LoginModel.fromJson(value.data);
          emit(LoginSuccessState(loginModel: login));
        })
        .catchError((error) {
          emit(LoginErrorState(errorMessage: error));
        });
  }
}
