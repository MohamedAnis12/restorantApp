
import 'package:craxe/data/models/MealModel.dart'; 

class CartItemModel {
  final int id;
  final int cartid;
  final int mealid;
  final int quantity;
  final MealModel meal; // ربط بتفاصيل الوجبة

  CartItemModel({
    required this.id,
    required this.cartid,
    required this.mealid,
    required this.quantity,
    required this.meal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      cartid: json['cartid'] as int,
      mealid: json['mealid'] as int,
      quantity: json['quantity'] as int,
      // 💡 تحليل كائن الوجبة الداخلي
      meal: MealModel.fromJson(json['meal'] as Map<String, dynamic>),
    );
  }
}