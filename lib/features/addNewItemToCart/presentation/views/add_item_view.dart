import 'package:craxe/data/models/MealModel.dart';
import 'package:craxe/features/addNewItemToCart/presentation/views/widgets/AddItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key, required this.meal});
  final MealModel meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        backgroundColor: Color(0xff3e2692),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xff3e2692),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(64.0),
              child:
                  (meal.image != null &&
                      meal.image!.isNotEmpty &&
                      (meal.image!.startsWith('http') ||
                          meal.image!.startsWith('https')))
                  ? Image.network(
                      meal.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/Burger.png");
                      },
                    )
                  : Image.asset("assets/images/Burger.png"),
            ),
          ),
          Expanded(flex: 3, child: AddItemContainer(meal: meal,)),
        ],
      ),
    );
  }
}
