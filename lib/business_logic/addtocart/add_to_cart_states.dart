// في ملف add_to_cart_states.dart
abstract class AddToCartStates {}

class AddToCartInitial extends AddToCartStates {}
class AddToCartLoading extends AddToCartStates {}
class AddToCartSuccess extends AddToCartStates {}
class AddToCartError extends AddToCartStates {
  final String errorMessage;
  AddToCartError({required this.errorMessage});
}