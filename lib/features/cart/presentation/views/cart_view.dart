import 'package:craxe/business_logic/cart/cart_cubit.dart';
import 'package:craxe/business_logic/cart/cart_states.dart';
import 'package:craxe/features/cart/presentation/views/widgets/custom_item_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  
  @override
  void initState() {
    super.initState();
    // 💡 عند تهيئة الشاشة، نبدأ جلب بيانات السلة
    context.read<CartCubit>().fetchCart();
  }
  
  @override
  Widget build(BuildContext context) {
    // 💡 استخدام BlocBuilder لعرض الواجهة بناءً على حالة الـ Cubit
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        
        // 1. حالة التحميل
        if (state is CartLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 2. حالة الخطأ
        if (state is CartErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.errorMessage}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // 3. حالة النجاح وعرض البيانات
        if (state is CartSuccessState) {
          final cartItems = state.cartResponse.cart.cartItems;
          final total = state.cartResponse.total;
          
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // عرض عدد الأصناف
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${cartItems.length} items in cart",
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  
                  // قائمة الأصناف
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          // 💡 تمرير بيانات الصنف إلى CustomItemCart
                          child: CustomItemCart(cartItem: cartItem),
                        );
                      },
                    ),
                  ),
                  
                  // السعر الإجمالي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        r"$" + total.toStringAsFixed(2), // عرض السعر الإجمالي
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffb0a01d),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const CustomBottun(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }

        // حالة البدء (Initial) أو حالة غير متوقعة
        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }
}

// الكود المساعد لـ CustomBottun لم يتغير
class CustomBottun extends StatelessWidget {
  const CustomBottun({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff5941ad),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "Check out",
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}