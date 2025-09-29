import 'package:flutter/material.dart';

Widget mediumText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.8),
    ),
  );
}
