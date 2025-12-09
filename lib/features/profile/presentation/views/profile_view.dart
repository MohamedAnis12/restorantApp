import 'package:craxe/features/addNewItem/presentation/views/addNewItem.dart';
import 'package:craxe/features/auth/presentation/views/widgets/customButton.dart';
import 'package:craxe/helper/theme_manager.dart';
import 'package:craxe/features/profile/controllers/profile_controller.dart';
import 'package:craxe/features/profile/presentation/widgets/account_info.dart';
import 'package:craxe/features/profile/presentation/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.lightTheme.value);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () async {
                  controller.lightTheme.toggle();
                  if (!controller.lightTheme.value) {
                    Get.changeThemeMode(ThemeMode.dark);
                    await ThemeManager().setTheme(ThemeModeState.dark);
                  } else {
                    Get.changeThemeMode(ThemeMode.light);
                    await ThemeManager().setTheme(ThemeModeState.light);
                  }
                },
                icon: !controller.lightTheme.value
                    ? const Icon(Icons.sunny, color: Colors.amber)
                    : const Icon(Icons.dark_mode, color: Colors.blueAccent),
              );
            }),
            Gap(8),
          ],
          iconTheme: IconThemeData(color: Colors.white, size: 40),
          title: FittedBox(
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Gap(20),
              const Column(children: [UserInfo(), Gap(10), AccountInfo()]),
              Gap(30),
              CusttomButton(onTap: () {

                Get.to(AddProductView(),transition: Transition.cupertino,duration: Duration(milliseconds: 500));
              }, text: "Add New item"),
              Gap(30),

              CusttomButton(
                onTap: () async {
                  //! logout
                  Get.offNamed('/login');
                },
                text: 'Logout',
              ),
              Gap(30),
            ],
          ),
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
            Text(massage!, style: TextStyle(color: Colors.grey, fontSize: 20)),
            Text(des!, style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}
