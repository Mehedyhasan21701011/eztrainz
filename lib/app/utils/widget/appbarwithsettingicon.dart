import 'package:flutter/material.dart';

/// Builds a professional-looking AppBar with a mascot/logo and profile avatar.
PreferredSizeWidget appBarWithSetting() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Image.asset(
        "assets/logo2.png",
        height: 40,
        width: 40,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.apps, size: 36, color: Colors.blue);
        },
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
            radius: 20,
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
