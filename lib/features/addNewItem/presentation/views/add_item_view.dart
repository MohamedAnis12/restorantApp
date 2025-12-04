import 'package:craxe/features/addNewItem/presentation/views/widgets/AddItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});

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
          Expanded(flex: 2, child: Image.asset("assets/images/Burger.png")),
          Expanded(flex: 3, child: AddItemContainer()),
        ],
      ),
    );
  }
}

