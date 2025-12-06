import 'package:craxe/features/cart/presentation/views/cart_view.dart';
import 'package:craxe/features/home/presentation/viewmodel/navbarCubit/nav_bar_cubit.dart';
import 'package:craxe/features/home/presentation/viewmodel/navbarCubit/nav_bar_state.dart';
import 'package:craxe/features/home/presentation/views/home_view.dart';
import 'package:craxe/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  final List<Widget> pages = [HomeView(), CartView(), ProfileView()];

   MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavbarCubit(),
      child: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return Scaffold(
            body: pages[state.currentIndex], // الصفحة الحالية
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) => context.read<NavbarCubit>().changePage(index),
              items: [
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
