import 'package:craxe/features/addNewItem/presentation/views/add_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomItemCard extends StatelessWidget {
  const CustomItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffece9eb).withOpacity(.3),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 125,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/Burger.png"),
                //  fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      "Beef Burger",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r"20$",
                      style: TextStyle(
                        color: Color(0xffa7a04d),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(AddItemView(),transition: Transition.fadeIn);
                      },
                      child: Icon(Icons.add_circle, color: Color(0xff0f7a44))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
