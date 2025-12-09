import 'package:craxe/data/models/MealModel.dart';
import 'package:craxe/features/addNewItemToCart/presentation/views/widgets/CustomRateContainer.dart';
import 'package:flutter/material.dart';

class AddItemContainer extends StatelessWidget {
  const AddItemContainer({super.key, required this.meal});
final MealModel meal;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRateContainer(),
                Text(
                  r"$5",
                  style: TextStyle(
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
                  meal.name.toString(),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.remove_circle_outline,
                      size: 32,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              meal.description.toString(),
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xff5941ad),
              ),
              child: Center(
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
