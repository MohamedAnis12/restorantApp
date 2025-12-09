import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/presentation/views/login_view.dart';
import 'package:craxe/features/auth/presentation/views/register_view.dart';
import 'package:craxe/features/home/presentation/views/HomePage.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:craxe/helper/theme_manager.dart';
import 'package:craxe/profile/controllers/profile_controller.dart';
import 'package:craxe/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CasheHelper().init();
  ThemeManager().loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeManager().getTheme(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ProfileController());
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
