// في ملف user_info.dart

import 'package:craxe/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class UserInfo extends GetView<ProfileController> {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        // 💡 عرض الصورة
        CircleAvatar(
          radius: 60,
          backgroundImage: controller.userImage.value.isNotEmpty
              ? NetworkImage(controller.userImage.value)
              : const AssetImage("assets/images/default_avatar.png") as ImageProvider,
        ),
        const Gap(10),
        // 💡 عرض الاسم
        Text(
          controller.userName.value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Gap(5),
      ],
    ));
  }
}