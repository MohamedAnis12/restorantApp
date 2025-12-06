import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/presentation/views/login_view.dart';
import 'package:craxe/features/auth/presentation/views/register_view.dart';
import 'package:craxe/features/home/presentation/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData.dark(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ),
      ],
    );
  }
}
