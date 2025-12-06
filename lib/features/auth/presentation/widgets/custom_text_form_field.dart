import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.controller,
  });

  final String hintText;
  final IconData prefixIcon;

  final String? Function(String?)? validator; // ← مهم
  final TextEditingController? controller; // ← مهم لو عايز تجيب القيم

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: TextStyle(height: .001, fontSize: 16),
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Color(0xfff8f8f8).withOpacity(.3),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),

      validator: validator, // ← كده تمام
    );
  }
}
