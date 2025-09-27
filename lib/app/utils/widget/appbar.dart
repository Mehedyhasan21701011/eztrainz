import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appbar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {
        Get.toNamed(Routes.HOME);
      },
      child: Icon(Icons.arrow_back_ios, color: Colors.blue),
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
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEEF4FA),
            radius: 20,
            child: Image.asset("assets/profile.png", fit: BoxFit.contain),
          ),
        ),
      ),
    ],
  );
}
