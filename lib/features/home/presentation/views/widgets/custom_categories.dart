import 'package:craxe/business_logic/home/Home_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCategories extends StatelessWidget {
  const CustomCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            CategoryItem(title: 'All', image: "assets/images/allFoodes.png"),
            CategoryItem(title: 'Burger', image: "assets/images/Burger.png"),
            CategoryItem(title: 'Pizza', image: "assets/images/pizzaIcon.png"),
            CategoryItem(
              title: 'Dessert',
              image: "assets/images/dessertIcon.png",
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title, required this.image});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async {
          await context.read<HomeCubit>().filterFunc(title);
        },
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xffece9eb).withOpacity(.3),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(child: Image.asset(image, fit: BoxFit.cover)),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
