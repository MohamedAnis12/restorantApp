// في ملف cart_response_model.dart

import 'package:craxe/data/models/CartModel.dart';

class CartResponseModel {
  final String message;
  final CartModel cart;
  final double total;

  CartResponseModel({
    required this.message,
    required this.cart,
    required this.total,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      message: json['message'] as String,
      // 💡 تحليل كائن السلة
      cart: CartModel.fromJson(json['cart'] as Map<String, dynamic>),
      // السعر الإجمالي قد يكون double أو int
      total: (json['total'] as num).toDouble(), 
    );
  }
}