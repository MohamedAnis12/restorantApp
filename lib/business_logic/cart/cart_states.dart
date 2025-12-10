// في ملف cart_states.dart
import 'package:craxe/data/models/CartResponseModel.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {
  final CartResponseModel cartResponse;

  CartSuccessState({required this.cartResponse});
}

class CartErrorState extends CartStates {
  final String errorMessage;

  CartErrorState({required this.errorMessage});
}