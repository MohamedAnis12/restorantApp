import 'package:craxe/features/cart/presentation/views/cart_view.dart';
import 'package:craxe/features/home/presentation/viewmodel/navbarCubit/nav_bar_cubit.dart';
import 'package:craxe/features/home/presentation/viewmodel/navbarCubit/nav_bar_state.dart';
import 'package:craxe/features/home/presentation/views/home_view.dart';
import 'package:craxe/profile/controllers/profile_controller.dart';
import 'package:craxe/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:craxe/business_logic/home/home_cubit.dart'; // تأكد من استيراد HomeCubit

class MyHomePage extends StatelessWidget {
  // 💡 Pages: لا تتطلب تغيير، لكن يجب أن تكون Widgets مستقرة
  final List<Widget> pages = [
    const HomeView(), 
    const CartView(), 
    const ProfileView()
  ];

  // 💡 Constructor: تهيئة ProfileController مرة واحدة عند بناء MyHomePage
  MyHomePage({super.key}) {
    // حل مشكلة ProfileController not found
    Get.put(ProfileController()); 
  }

  @override
  Widget build(BuildContext context) {
    
    // 💡 استخدام MultiBlocProvider لتوفير NavbarCubit و HomeCubit
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavbarCubit()),
        // توفير HomeCubit هنا يجعله متاحًا لـ HomeView كأحد الأطفال
        BlocProvider(create: (_) => HomeCubit()), 
      ],
      
      child: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return Scaffold(
            // 💡 Body: IndexedStack يحافظ على حالة HomeView نشطة في الذاكرة
            body: IndexedStack(
              index: state.currentIndex,
              children: pages,
            ),
            
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              // onTap: يجب أن يقرأ NavbarCubit فقط
              onTap: (index) => context.read<NavbarCubit>().changePage(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 32),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined, size: 32),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded, size: 32),
                  label: '',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}