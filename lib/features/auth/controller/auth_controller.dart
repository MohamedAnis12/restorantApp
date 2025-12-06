import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final signupEmailController = TextEditingController();
  final signupPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final signupNameController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();


}
