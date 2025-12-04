import 'package:craxe/features/Login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: "ex:123456789",
      icon: Icons.lock,
      obscureText: true,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "";
        }
        if (value.length < 6) {
          return "";
        }
        return null;
      },
    );
  }
}
