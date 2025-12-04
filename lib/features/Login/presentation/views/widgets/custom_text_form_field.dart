import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.validator,
    this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final IconData icon;

  final String? Function(String?)? validator; // ← مهم
  final TextEditingController? controller; // ← مهم لو عايز تجيب القيم
  final bool obscureText; // ← مهم لو هي Password

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: TextStyle(height: .001, fontSize: 16),
          prefixIcon: Icon(icon),
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
      ),
    );
  }
}
