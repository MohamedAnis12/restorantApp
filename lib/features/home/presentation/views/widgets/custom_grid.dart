import 'package:craxe/data/models/MealModel.dart';
import 'package:craxe/features/home/presentation/views/widgets/custom_item_card.dart';
import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  // 💡 يجب أن تستقبل قائمة المنتجات كمدخل
  final List<MealModel> meals;
  
  const CustomGrid({
    super.key,
    required this.meals, // جعل القائمة مدخلاً إجبارياً
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      
      itemCount: meals.length, 
      
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: .8,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];
        
        return CustomItemCard(
          meal: meal, 
        );
      },
    );
  }
}