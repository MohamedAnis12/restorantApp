import 'package:craxe/constants/assets.dart';
import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/helper/validator.dart';
import 'package:craxe/features/auth/presentation/views/login_view.dart';
import 'package:craxe/features/auth/presentation/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/auth/presentation/widgets/customButton.dart';
import 'package:craxe/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                key: controller.registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Center(child: Image.asset(Assets.burgerlogo, height: 150)),

                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 50),
                    CustomTextFormField(
                      controller: controller.signupNameController,
                      hintText: "ex: Amr Diab",
                      prefixIcon: Icons.email,
                      validator: Validator.emailValidator(),
                    ),
                    SizedBox(height: 15),

                    /// Email
                    CustomTextFormField(
                      controller: controller.signupEmailController,
                      hintText: "ex:email@gmail.com",
                      prefixIcon: Icons.email,
                      validator: Validator.emailValidator(),
                    ),

                    SizedBox(height: 15),

                    /// Password
                    CustomPasswordFormField(
                      controller: controller.signupPassController,
                      hintText: "ex:123456789",
                      validator: Validator.signupPasswordValidator(),
                    ),
                    SizedBox(height: 15),

                    CustomPasswordFormField(
                      controller: controller.passwordController,
                      hintText: "confirm password",
                      validator: Validator.confirmPasswordValidator(
                        orgPasswordGetter: () =>
                            controller.signupPassController.text,
                      ),
                    ),
                    SizedBox(height: 30),

                    /// Button
                    CusttomButton(
                      text: 'Register',
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
                        Text("Already Have an account"),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "Login",
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
