import 'package:flutter/material.dart';

Widget routeButton(String text, {VoidCallback? onpress, String? imgPath}) {
  return TextButton(
    onPressed: onpress,
    style: TextButton.styleFrom(
      foregroundColor: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // ✅ Keeps it compact
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
        ),
        const SizedBox(width: 8), // space between text and icon
        if (imgPath != null) ...[Image.asset(imgPath, width: 24, height: 24)],
      ],
    ),
  );
}
