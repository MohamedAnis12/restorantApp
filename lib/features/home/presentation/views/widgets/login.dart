import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Menu",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w500),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              icon: Icon(Icons.person, size: 46),
            ),
          ],
        ),
      ],
    );
  }
}
