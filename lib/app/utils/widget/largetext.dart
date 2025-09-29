import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

Widget largeText(String text, {double? letterSpace}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 32,
      color: TColors.primary,
      fontWeight: FontWeight.bold,
      letterSpacing: letterSpace ?? 0,
    ),
  );
}
