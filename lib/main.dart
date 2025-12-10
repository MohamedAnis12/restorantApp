import 'package:craxe/business_logic/home/Home_Cubit.dart';
import 'package:craxe/business_logic/login/login_cubit.dart';
import 'package:craxe/business_logic/register/register_cubit.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/features/addNewItem/presentation/views/addNewItem.dart';
import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/presentation/views/login_view.dart';
import 'package:craxe/features/auth/presentation/views/register_view.dart';
import 'package:craxe/features/home/presentation/views/HomePage.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:craxe/helper/theme_manager.dart';
import 'package:craxe/features/profile/controllers/profile_controller.dart';
import 'package:craxe/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:craxe/business_logic/cart/cart_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper().init();

  ThemeManager().loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 استخدام MultiBlocProvider لتوفير HomeCubit و CartCubit بشكل عام
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit()), // 💡 توفير CartCubit هنا
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeManager().getTheme(),
        getPages: [
          GetPage(
            name: '/login',
            page: () => BlocProvider(
              create: (context) => LoginCubit(),
              child: const LoginView(),
            ),
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
            page: () => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => RegisterCubit()),
                BlocProvider(create: (context) => LoginCubit()),
              ],
              child: const RegisterView(),
            ),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthController());
            }),
          ),
          GetPage(
            name: '/home',
            // HomeCubit و CartCubit متاحان الآن من MultiBlocProvider الخارجي
            page: () => MyHomePage(),
          ),
          GetPage(
            name: '/addProduct',
            page: () => const AddProductView(),
          ),
        ],
      ),
    );
  }
}