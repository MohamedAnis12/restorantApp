import 'package:craxe/features/Login/presentation/views/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/Login/presentation/views/widgets/customButton.dart';
import 'package:craxe/features/Login/presentation/views/widgets/cutom_email_form_field.dart';
import 'package:craxe/features/Register/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    // child: Image.asset(
                    //   "assets/images/LogoBurger.png",
                    //   height: 150,
                    // ),
                  ),

                  SizedBox(height: 40),

                  /// Email
                  CustomEmailFormField(controller: emailController),

                  SizedBox(height: 20),

                  /// Password
                  CustomPasswordFormField(controller: passwordController),

                  SizedBox(height: 30),

                  /// Button
                  CusttomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");
                        Get.back();
                      } else {
                        CusttomSnackBar();
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
                          Get.to(
                            RegisterView(),
                            transition: Transition.leftToRight,
                            duration: Duration(seconds: 1),
                          );
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
    );
  }
}

void CusttomSnackBar() {
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
