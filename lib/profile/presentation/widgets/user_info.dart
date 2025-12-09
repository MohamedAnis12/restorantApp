import 'package:craxe/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UserInfo extends GetView<ProfileController> {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xff5941ad),
                child: Text(
                  "YA",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(10),
              Text(
                controller.fullName.value,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const Gap(5),
              Text(
                "email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
