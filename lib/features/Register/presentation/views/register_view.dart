import 'package:craxe/features/Login/presentation/views/widgets/CustomPasswordFormField.dart';
import 'package:craxe/features/Login/presentation/views/widgets/customButton.dart';
import 'package:craxe/features/Login/presentation/views/widgets/cutom_email_form_field.dart';
// بما أن هذا هو شاشة التسجيل، سنفترض أن شاشة تسجيل الدخول هي وجهتنا التالية
import 'package:craxe/features/Login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// ملاحظة: بما أن حقل الاسم ليس مخصصاً، سأستخدم CustomEmailFormField مؤقتاً كبديل
// ولكن يفضل تسميته CustomTextFormField إذا لم يكن للبريد الإلكتروني

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  // حقول الإدخال لشاشة التسجيل
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // حقل إضافي لتأكيد كلمة المرور

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Register", // تم التغيير من Login إلى Register
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Placeholder for Image (LogoBurger)

                  SizedBox(height: 40),

                  /// Full Name
                  CustomEmailFormField( // يفضل تغيير اسم هذا الويدجيت ليتناسب مع الاسم
                      controller: fullNameController,
                  ),

                  SizedBox(height: 20),

                  /// Email
                  CustomEmailFormField(controller: emailController),

                  SizedBox(height: 20),

                  /// Password
                  CustomPasswordFormField(controller: passwordController),

                  SizedBox(height: 20),

                  /// Confirm Password (حقل إضافي للتسجيل)
                  CustomPasswordFormField(
                      controller: confirmPasswordController,
                  ),

                  SizedBox(height: 30),

                  /// Button (Register)
                  CusttomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // التحقق من تطابق كلمتي المرور
                        if (passwordController.text != confirmPasswordController.text) {
                            CusttomSnackBar(
                                title: "خطأ في كلمة المرور", 
                                message: "كلمة المرور وتأكيد كلمة المرور غير متطابقين.");
                            return; // توقف العملية إذا كان هناك عدم تطابق
                        }
                        
                        print("Full Name: ${fullNameController.text}");
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");
                        
                        // هنا يتم تنفيذ منطق التسجيل (API Call)
                        
                        // بعد التسجيل الناجح، نعود أو ننتقل إلى شاشة تسجيل الدخول
                        Get.off(() => LoginView(), transition: Transition.rightToLeft, duration: Duration(seconds: 1));
                        
                      } else {
                        CusttomSnackBar(title: "خطأ", message: "يرجى ملء جميع الحقول بشكل صحيح.");
                      }
                    },
                    // يفضل أن يكون نص الزر "Register"
                  ),
                  
                  SizedBox(height: 40),
                  
                  // التعديل: إذا كان لديك حساب بالفعل، انتقل إلى شاشة تسجيل الدخول
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Already have an account?"),
                      InkWell(
                        onTap: () {
                          // الانتقال إلى شاشة تسجيل الدخول
                          Get.back();
                        },
                        child: Text(
                          "Login now!",
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

// تم تعديل الدالة لتصبح أكثر مرونة في عرض رسالة الخطأ
void CusttomSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.8),
    colorText: Colors.white,
    margin: EdgeInsets.all(16),
    borderRadius: 12,
    duration: Duration(seconds: 3),
  );
}