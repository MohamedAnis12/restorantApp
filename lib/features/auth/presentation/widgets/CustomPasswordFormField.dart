import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        obscureText: obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorStyle: TextStyle(height: .001, fontSize: 16),
          prefixIcon: Icon(Icons.lock),
          suffix: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: obscureText
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
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

        validator: widget.validator, // ← كده تمام
      ),
    );
  }
}
