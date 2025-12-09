import 'package:craxe/functions/is_dark.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final fullName = ''.obs;
  final lightTheme = (!isDark()).obs;
}
