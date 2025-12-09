import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  
  // controllers used for Login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  // controllers used for Register/Signup
  final signupEmailController = TextEditingController();
  final signupPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final signupNameController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();

  // 💡 الحل: يجب تهيئته مباشرةً وليس إرجاع قيمة null
  final phoneController = TextEditingController(); 
}