import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

Widget primaryButton(
  String text, {
  double? width,
  double? radius,
  String? imgPath,
  VoidCallback? onTap,
}) {
  final double finalRadius = radius ?? 12.0;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(finalRadius),
      child: Ink(
        width: width ?? double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: TColors.buttonSecondary,
          borderRadius: BorderRadius.circular(finalRadius),
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
