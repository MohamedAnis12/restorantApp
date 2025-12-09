import 'package:craxe/features/addNewItem/presentation/views/addNewItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  final bool isAdmin = true;
  final bool isDark=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Profile", style: TextStyle(fontSize: 32)),
            ),
            CustomUserCard(),
            Spacer(flex: 1),
            isAdmin
                ? InkWell(
                    onTap: () {
                      Get.to(
                        AddProductView(),
                        transition: Transition.downToUp,
                        duration: Duration(milliseconds: 600),
                      );
                    },
                    child: Text(
                      "add new Item",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(""),
            Spacer(flex: 1),

            CustomLogoutBotton(),
            Spacer(flex: 1),

          ],
        ),
      ),
    );
  }
}

class CustomUserCard extends StatelessWidget {
  const CustomUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 58),
          Text(
            "3amr diab",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("3amro Diab ya **** @gmail.com"),
        ],
      ),
    );
  }
}

class CustomLogoutBotton extends StatelessWidget {
  const CustomLogoutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff5941ad),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
