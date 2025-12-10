import 'dart:developer';

import 'package:craxe/business_logic/home/Home_Cubit.dart';
import 'package:craxe/business_logic/home/home_states.dart';
import 'package:craxe/features/home/presentation/views/widgets/custom_categories.dart';
import 'package:craxe/features/home/presentation/views/widgets/custom_grid.dart';
import 'package:craxe/features/home/presentation/views/widgets/custome_heder_image.dart';
import 'package:craxe/features/home/presentation/views/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 💡 استيراد BLoC

// 1. التحويل إلى StatefulWidget
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // 💡 2. بدء عملية جلب المنتجات عند فتح الشاشة
    // يجب توفير HomeCubit في المسار (main.dart) ليتمكن التطبيق من قراءته
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80, child: Login()),
              const CustomCategories(),
              const CustomeHederImage(),
              Row(
                children: const [
                  Text(
                    "Popular",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10), // فاصل صغير
              // 💡 3. استخدام BlocBuilder لمعالجة حالات جلب البيانات
              BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    // حالة التحميل: عرض دائرة تقدم
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeErrorState) {
                    // حالة الخطأ: عرض رسالة خطأ
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  } else if (state is HomeSuccessState) {
                    // حالة النجاح: عرض المنتجات
                    // التأكد من أن القائمة ليست فارغة قبل تمريرها
                    final meals = state.mealsResponseModel.meals;

                    if (meals == null || meals.isEmpty) {
                      return const Center(child: Text("No products found."));
                    }
                    log("rebuild...........");
                    // 💡 تمرير قائمة الوجبات الفعلية إلى CustomGrid
                    return CustomGrid(meals: meals);
                  }
                  // حالة Initial أو أي حالة أخرى
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
