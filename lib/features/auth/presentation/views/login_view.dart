import 'package:craxe/constants/assets.dart';
import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/helper/validator.dart';
import 'package:craxe/features/auth/presentation/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/auth/presentation/widgets/customButton.dart';
import 'package:craxe/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 32),
            onPressed: () {
              Get.back(); // ترجع خطوة للوراء
            },
          ),
        ),
        body: SafeArea(
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
                    Center(child: Image.asset(Assets.burgerlogo, height: 150)),

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

                    /// Button
                    CusttomButton(
                      text: "Login",
                      onTap: () {
                        if (controller.loginFormKey.currentState!.validate()) {
                          print("Email: ${controller.emailController.text}");
                          print(
                            "Password: ${controller.passwordController.text}",
                          );
                          Get.back();
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
