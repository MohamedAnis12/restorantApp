import 'package:craxe/business_logic/login/login_states.dart';
import 'package:craxe/constants/constants.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/login_model.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    DioHelper.postData(
          url: 'users/login',
          data: {'email': email, 'password': password},
        )
        .then((value) {
          LoginModel login = LoginModel.fromJson(value.data);
          CasheHelper().saveData(
            key: Constants.tokenKey, // المفتاح الذي عرفناه
            value: login.token!, // نفترض أن LoginModel لديه حقل token
          );
          emit(LoginSuccessState(loginModel: login));
        })
        .catchError((error) {
          emit(LoginErrorState(errorMessage: error.toString()));
        });
  }
}
