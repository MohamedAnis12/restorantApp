import 'package:craxe/features/addNewItem/presentation/views/widgets/CustomRateContainer.dart';
import 'package:flutter/material.dart';

class AddItemContainer extends StatelessWidget {
  const AddItemContainer({super.key});

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
                  "Beef Burger",
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
                        color: Colors.white
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
              "Original Beef Burger, barbecue grill or stir fry in a medium temperature pan, on both sides for 3-4 each, preferably cover the pan during cooking , can be served with toppings of your choice (mushroom, extra cheese, onion rings, tomatoes…)",
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
