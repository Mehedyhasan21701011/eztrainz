import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

Widget primaryButton(
  String text, {
  double? width,
  String? imgPath,
  VoidCallback? onTap, // ✅ allows click callback
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap, // ✅ clickable effect
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.blue.withOpacity(0.2),
      highlightColor: Colors.blue.withOpacity(0.1),
      child: Container(
        width: width ?? double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: TColors.buttonSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: TColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (imgPath != null) ...[
              const SizedBox(width: 16),
              Image.asset(imgPath, width: 24, height: 24),
            ],
          ],
        ),
      ),
    ),
  );
}
