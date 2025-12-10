import 'package:craxe/business_logic/login/login_cubit.dart';
import 'package:craxe/business_logic/login/login_states.dart';
import 'package:craxe/constants/assets.dart';
import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/helper/validator.dart';
import 'package:craxe/features/auth/presentation/views/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/auth/presentation/views/widgets/customButton.dart';
import 'package:craxe/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              custtomSnackBar();
            } else if (state is LoginSuccessState) {
              Get.offAllNamed('/home'); // أو المسار الصحيح لشاشة المنتجات;
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Image.asset(Assets.burgerlogo, height: 150),
                        ),

                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 60),

                        /// Email
                        CustomTextFormField(
                          controller: controller.emailController,
                          hintText: "ex:email@gmail.com",
                          prefixIcon: Icons.email,
                          validator: Validator.emailValidator(),
                        ),

                        SizedBox(height: 20),

                        /// Password
                        CustomPasswordFormField(
                          controller: controller.passwordController,
                          hintText: "ex:123456789",
                          validator: Validator.loginPasswordValidator(),
                        ),

                        SizedBox(height: 30),

                        state is LoginLoadingState
                            ? Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xff7344d0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : CusttomButton(
                                text: "Login",
                                onTap: () async {
                                  if (controller.loginFormKey.currentState!
                                      .validate()) {
                                    // 1. استرجاع الكيوبت باستخدام context.read
                                    final loginCubit = context
                                        .read<LoginCubit>();

                                    // 2. استدعاء دالة تسجيل الدخول بالبيانات
                                    await loginCubit.userLogin(
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text,
                                    );
                                  } else {
                                    custtomSnackBar();
                                  }
                                },
                              ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("I Don't have an account"),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/register');
                              },
                              child: Text(
                                "Creat one now!",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void custtomSnackBar() {
  Get.snackbar(
    "Error",
    "Please fill all fields correctly",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.8),
    colorText: Colors.white,
    margin: EdgeInsets.all(16),
    borderRadius: 12,
    duration: Duration(seconds: 2),
  );
}
