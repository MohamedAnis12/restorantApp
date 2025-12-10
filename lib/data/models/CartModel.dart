import 'package:craxe/data/models/cart_item_model.dart';

class CartModel {
  final int id;
  final int userid;
  final List<CartItemModel> cartItems;

  CartModel({
    required this.id,
    required this.userid,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // 💡 تحليل قائمة العناصر
    final List<dynamic> cartItemsJson = json['cart_items'] as List<dynamic>;
    final List<CartItemModel> cartItems = cartItemsJson
        .map((itemJson) => CartItemModel.fromJson(itemJson as Map<String, dynamic>))
        .toList();

    return CartModel(
      id: json['id'] as int,
      userid: json['userid'] as int,
      cartItems: cartItems,
    );
  }
}