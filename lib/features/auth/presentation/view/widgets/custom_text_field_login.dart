import 'package:flutter/material.dart';

class CustomTextFieldLogin extends StatelessWidget {
  final String hinText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFieldLogin({
    super.key,
    required this.hinText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hinText,
        fillColor: const Color(0xffF8F9FA),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        suffixIcon: suffixIcon != null
            ? InkWell(
          onTap: onSuffixTap,
          child: Icon(suffixIcon),
        )
            : null,
      ),
    );
  }
}
