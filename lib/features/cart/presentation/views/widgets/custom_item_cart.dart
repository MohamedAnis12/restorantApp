// في ملف custom_item_cart.dart

import 'package:craxe/business_logic/cart/cart_cubit.dart';
import 'package:craxe/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomItemCart extends StatelessWidget {
  const CustomItemCart({super.key, required this.cartItem});
  final CartItemModel cartItem;

  void removeItem(BuildContext context) {
    // 💡 الحصول على mealId من الـ cartItem ليتوافق مع متطلبات الـ API
    final mealId = cartItem.meal.id ?? 0;

    // 💡 استدعاء Cubit لحذف الصنف، وتمرير الـ mealId المطلوب
    context.read<CartCubit>().removeItem(
      cartItemId: cartItem.id,
      mealId: mealId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = cartItem.meal;
    final quantity = cartItem.quantity;
    final price = meal.price ?? 0.0;
    final totalItemPrice = price * quantity;

    return Container(
      height: 150,
      width: double.infinity,
      // 💡 إضافة Padding أفقي لضبط المسافات من الأطراف
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // 💡 إبقاء التباعد SpaceBetween
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- 1. حاوية الصورة ---
          Container(
            height: 150,
            width: 100, // حجم ثابت للصورة
            decoration: BoxDecoration(
              color: const Color(0xffedebeb).withOpacity(.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                (meal.image != null &&
                    meal.image!.isNotEmpty &&
                    meal.image!.startsWith('http'))
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      meal.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/Burger.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                : Image.asset("assets/images/Burger.png"),
          ),

          // 💡 إضافة مسافة فاصلة صغيرة بين الصورة والنص
          const SizedBox(width: 12.0),

          // --- 2. الاسم والسعر والكمية (يجب أن يكون Expanded ليأخذ بقية المساحة) ---
          Expanded(
            // 💡 استخدام Expanded لضمان عدم تجاوز النص
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  meal.name ?? "Unknown Item",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  r"$ " + totalItemPrice.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xffb0a01d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Qty: ${quantity}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          // --- 3. زر الإزالة ---
          // لم نعد نحتاج لـ Spacer() لأننا استخدمنا Expanded
          GestureDetector(
            onTap: () => removeItem(context),
            // 💡 تغليف الأيقونة بـ Padding خفيف لتحسين منطقة الضغط
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ), // مسافة من الأعلى واليسار
              child: const Icon(
                Icons.highlight_remove_rounded,
                color: Colors.red,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
