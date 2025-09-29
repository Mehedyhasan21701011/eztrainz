import 'package:eztrainz/app/utils/constraint/colors.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  bool? obscureText,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColor.textFieldHintText),
          filled: true,
          fillColor: AppColor.textFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    ],
  );
}
