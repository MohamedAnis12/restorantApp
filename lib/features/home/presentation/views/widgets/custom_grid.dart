import 'package:craxe/features/home/presentation/views/widgets/custom_item_card.dart';
import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // لتعطيل تمرير الـ GridView داخليًا
      itemCount: 10, 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: .8,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, num) {
        return CustomItemCard();
      },
    );
  }
}
