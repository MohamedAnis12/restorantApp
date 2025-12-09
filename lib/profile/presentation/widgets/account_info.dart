import 'package:craxe/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AccountInfo extends GetView<ProfileController> {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 70,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color(0xff5941ad),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Account Information',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Gap(15),
            buildRow(
              Icons.person,
              massage: 'Full Name',
              des: controller.fullName.value,
            ),
            const Gap(10),
            const Divider(color: Colors.grey),
            buildRow(
              Icons.email_outlined,
              massage: 'Email Address',
              des: 'rrrrrrrrrrrrrrrrrrrrrrrrrrr',
            ),
            const Gap(25),
          ],
        ),
      ),
    );
  }

  Row buildRow(IconData icon, {String? massage, String? des}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Color(0xff5941ad), size: 30),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              massage!,
              style: TextStyle(color: Colors.grey,fontSize:20),
            ),
            Text(des!, style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}
