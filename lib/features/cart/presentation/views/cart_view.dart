import 'package:craxe/features/cart/presentation/views/widgets/custom_item_cart.dart';
import 'package:flutter/material.dart';
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("2 items in cart", style: TextStyle(fontSize: 32)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, num) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomItemCart(),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  r"$20",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb0a01d),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomBottun(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CustomBottun extends StatelessWidget {
  const CustomBottun({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff5941ad),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
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
