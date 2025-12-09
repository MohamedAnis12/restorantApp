import 'package:craxe/business_logic/register/register_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/RegisterModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String image,
    required String phonenumber,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
          url: 'users/add-user',
          data: {
            'name': name,
            'email': email,
            'password': password,
            'gender': gender,
            'image': image,
            'phonenumber': phonenumber,
          },
        )
        .then((value) {
          Registermodel register = Registermodel.fromJson(value.data);
          emit(RegisterSuccessState(registerModel: register));
        })
        .catchError((error) {
          emit(RegisterFailureState(errorMessage: error.toString()));
        });
  }
}
