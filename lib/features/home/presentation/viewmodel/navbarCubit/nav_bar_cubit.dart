// navbar_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:craxe/features/home/presentation/viewmodel/navbarCubit/nav_bar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarState(0)); // أول صفحة هي Home

  void changePage(int index) {
    emit(NavbarState(index));
  }
}
