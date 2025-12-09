import 'package:craxe/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AccountInfo extends GetView<ProfileController> {
  const AccountInfo({super.key});

  // 💡 دالة مساعدة لعرض صف واحد من المعلومات
  Row buildRow(IconData icon, {String? massage, required String des}) {
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
              child: Icon(icon, color: const Color(0xff5941ad), size: 30),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              massage!,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            // 💡 استخدام FixedBox لتجنب تجاوز النص الطويل
            SizedBox(
              width: Get.width * 0.7, 
              child: Text(
                des, 
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis, // لمنع تجاوز النص
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
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
            
            // 💡 استخدام Obx لربط حقول البيانات بالـ Controller
            Obx(() {
              return Column(
                children: [
                  // --- 1. عرض الاسم الكامل ---
                  buildRow(
                    Icons.person,
                    massage: 'Full Name',
                    // 💡 ربطها بـ controller.userName
                    des: controller.userName.value, 
                  ),
                  const Gap(10),
                  const Divider(color: Colors.grey),
                  
                  // --- 2. عرض الإيميل ---
                  buildRow(
                    Icons.email_outlined,
                    massage: 'Email Address',
                    // 💡 ربطها بـ controller.userEmail
                    des: controller.userEmail.value,
                  ),
                  const Gap(25),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}