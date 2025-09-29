import 'package:flutter/material.dart';

Widget smallText(
  String text, {
  double? opaCity,
  TextAlign? textAlign, // ✅ nullable textAlign
}) {
  return Text(
    text,
    textAlign: textAlign, // will use default if null
    style: TextStyle(
      fontSize: 14,
      color: opaCity != null ? Colors.black.withOpacity(opaCity) : Colors.black,
    ),
  );
}
