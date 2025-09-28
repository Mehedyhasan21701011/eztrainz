import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appbar() {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leading: GestureDetector(
      onTap: () {
        Get.toNamed(Routes.HOME);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.blue),
      ),
    ),
    title: Image.asset(
      "assets/logo.png",
      width: 150,
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
      GestureDetector(
        onTap: () {
          // ✅ Navigate to Profile page
          // Get.toNamed('/profile'); // Or Get.to(ProfileView());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILEPAGE);
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFFEEF4FA),
              radius: 18,
              child: Image.asset("assets/profile.png", fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    ],
  );
}
