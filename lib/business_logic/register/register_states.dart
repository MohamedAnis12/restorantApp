import 'package:craxe/data/models/RegisterModel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
final Registermodel registerModel;

  RegisterSuccessState({required this.registerModel});
}

class RegisterFailureState extends RegisterStates {
  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}
