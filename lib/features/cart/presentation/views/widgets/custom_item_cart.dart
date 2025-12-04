import 'package:flutter/material.dart';

class CustomItemCart extends StatelessWidget {
  const CustomItemCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xffedebeb).withOpacity(.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset("assets/images/pizzaIcon.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Noodels", style: TextStyle(fontSize: 18)),
              Text(
                r"$20",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffb0a01d),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.add_circle_outline, size: 32),
                  Text(
                    "1",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.remove_circle_outline, size: 32),
                ],
              ),
            ],
          ),
          SizedBox(width: 120),
          Icon(Icons.highlight_remove_rounded, color: Colors.red, size: 32),
          SizedBox(width: 1),
        ],
      ),
    );
  }
}