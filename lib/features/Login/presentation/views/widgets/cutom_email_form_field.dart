import 'package:craxe/features/Login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: "ex:email@gmail.com",
      icon: Icons.email,
      controller: controller,
      
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "";
        }
        if (!value.contains("@")) {
          return "";
        }
        return null;
      },
    );
  }
}
