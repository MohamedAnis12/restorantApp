import 'package:craxe/business_logic/addtocart/add_to_cart_cubit.dart';
import 'package:craxe/business_logic/addtocart/add_to_cart_states.dart';
import 'package:craxe/data/models/MealModel.dart';
import 'package:craxe/features/addNewItemToCart/presentation/views/widgets/CustomRateContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemContainer extends StatelessWidget {
  const AddItemContainer({super.key, required this.meal});
  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    // 💡 توفير Cubit على مستوى هذا الـ Widget
    return BlocProvider(
      create: (_) => AddToCartCubit(),
      child: _AddItemContainerBody(meal: meal),
    );
  }
}

class _AddItemContainerBody extends StatefulWidget {
  const _AddItemContainerBody({required this.meal});
  final MealModel meal;

  @override
  State<_AddItemContainerBody> createState() => _AddItemContainerBodyState();
}

class _AddItemContainerBodyState extends State<_AddItemContainerBody> {
  int quantity = 1; // 💡 حالة محلية للكمية

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void addToCart() {
    final cubit = context.read<AddToCartCubit>();
    // 💡 يفترض أن الـ mealId موجود في meal.id أو ما شابه
    final mealId = int.tryParse(widget.meal.id?.toString() ?? '0') ?? 0;

    if (mealId > 0) {
      cubit.addItemToCart(mealId: mealId, quantity: quantity);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Meal ID is invalid.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartStates>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item added to cart successfully!')),
          );
          // يمكنك إغلاق الشاشة هنا إذا أردت Get.back()
        } else if (state is AddToCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddToCartLoading;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1. السعر والتقييم
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomRateContainer(),
                    Text(
                      r"$" +
                          (widget.meal.price?.toString() ??
                              "0"), // عرض السعر الحقيقي
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffdeba07),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.meal.name.toString(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 32,
                            color: Colors.white,
                          ),
                          onPressed: isLoading ? null : increaseQuantity,
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 32,
                            color: Colors.white,
                          ),
                          onPressed: isLoading ? null : decreaseQuantity,
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.meal.description.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: isLoading ? null : addToCart,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff5941ad),
                    ),
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Add to cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
