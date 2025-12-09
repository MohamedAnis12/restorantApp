// في ملف add_product_states.dart

abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}
class AddProductLoadingState extends AddProductStates {}

class AddProductSuccessState extends AddProductStates {
  final String message; // يمكن أن تحمل رسالة نجاح من السيرفر

  AddProductSuccessState({required this.message});
}

class AddProductErrorState extends AddProductStates {
  final String errorMessage;

  AddProductErrorState({required this.errorMessage});
}