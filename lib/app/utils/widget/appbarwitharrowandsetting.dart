import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Builds a professional-looking AppBar with a mascot/logo and profile avatar.
PreferredSizeWidget appBarWithArrowAndSetting() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blue),
      ),
    ),
    title: Image.asset(
      "assets/logo.png",
      width: 140,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          "EzTrainz",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        );
      },
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEEF4FA),
            radius: 16,
            child: ClipOval(
              child: Image.asset(
                "assets/setting.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.blue);
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
