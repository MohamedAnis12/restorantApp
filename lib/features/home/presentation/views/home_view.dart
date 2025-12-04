import 'package:craxe/features/home/presentation/views/widgets/custom_categories.dart';
import 'package:craxe/features/home/presentation/views/widgets/custom_grid.dart';
import 'package:craxe/features/home/presentation/views/widgets/custome_heder_image.dart';
import 'package:craxe/features/home/presentation/views/widgets/login.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Login(),
                ),
              CustomCategories(),
              CustomeHederImage(),
              Row(
                children: [
                  Text(
                    "Popular",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
