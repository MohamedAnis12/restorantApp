import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xff7344d0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
           text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
