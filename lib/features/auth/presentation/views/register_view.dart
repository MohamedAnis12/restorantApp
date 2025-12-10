import 'package:craxe/business_logic/register/register_cubit.dart';
import 'package:craxe/business_logic/register/register_states.dart';
import 'package:craxe/constants/assets.dart';
import 'package:craxe/features/auth/controller/auth_controller.dart';
import 'package:craxe/features/auth/helper/validator.dart';
import 'package:craxe/features/auth/presentation/views/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/auth/presentation/views/widgets/customButton.dart';
import 'package:craxe/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  void custtomSnackBar(String errorMessage) {
    print(errorMessage);
    Get.snackbar(
      "error",
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterFailureState) {
          custtomSnackBar(state.errorMessage.toString());
        } else if (state is RegisterSuccessState) {
          Get.back();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(/* ... */),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.registerFormKey, // 💡 تم تصحيح الـ Key هنا
                    child: Column(
                      // ... باقي الـ Widgets كما هي
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Image.asset(Assets.burgerlogo, height: 150),
                        ),
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

                        /// Name
                        CustomTextFormField(
                          controller: controller.signupNameController,
                          hintText: "Name",
                          prefixIcon: Icons.person,
                          validator: Validator.signupNameValidator(),
                        ),
                        SizedBox(height: 15),

                        /// Email
                        CustomTextFormField(
                          controller: controller.signupEmailController,
                          hintText: "email",
                          prefixIcon: Icons.email,
                          validator: Validator.emailValidator(),
                        ),
                        SizedBox(height: 15),

                        // 💡 إضافة حقل رقم الهاتف
                        CustomTextFormField(
                          controller: controller.phoneController,
                          hintText: "phone num",
                          prefixIcon: Icons.phone,
                          validator:
                              Validator.signupPasswordValidator(), // استخدم Validator مناسب للهاتف
                        ),
                        SizedBox(height: 15),
                        //loginform
                        /// Password
                        CustomPasswordFormField(
                          controller: controller.signupPassController,
                          hintText: "Password",
                          validator: Validator.signupPasswordValidator(),
                        ),
                        SizedBox(height: 15),

                        CustomPasswordFormField(
                          controller: controller
                              .passwordController, // هذا هو Confirm Password
                          hintText: "password",
                          validator: Validator.confirmPasswordValidator(
                            orgPasswordGetter: () =>
                                controller.signupPassController.text,
                          ),
                        ),
                        SizedBox(height: 30),

                        /// Button
                        CusttomButton(
                          // 💡 عرض مؤشر تحميل (Loading) إذا كانت الحالة هي LoginLoadingState
                          text: (state is RegisterLoadingState)
                              ? 'loading.....'
                              : 'Register',
                          onTap: (state is RegisterLoadingState)
                              ? null
                              : () async {
                                  // تعطيل الزر أثناء التحميل

                                  // 💡 3. تنفيذ اللوجيك
                                  if (controller.registerFormKey.currentState!
                                      .validate()) {
                                    // 💡 تم تصحيح الـ Key
                                await    context.read<RegisterCubit>().userRegister(
                                      name:
                                          controller.signupNameController.text,
                                      email:
                                          controller.signupEmailController.text,
                                      password:
                                          controller.signupPassController.text,
                                      phonenumber: controller
                                          .phoneController
                                          .text, // استخدام الهاتف
                                      gender: 'male',
                                      image: 'urls',
                                      
                                    );
                                  } else {
                                    custtomSnackBar("fill all feids");
                                  }
                                },
                        ),
                        // ... باقي الكود
                        SizedBox(height: 40),
                        // ... Row للـ Login
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
