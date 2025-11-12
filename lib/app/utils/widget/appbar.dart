import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Solution 1: Using leadingWidth to give more space
PreferredSizeWidget appBar({
  String? leftIconPath,
  String? rightIconPath,
  VoidCallback? onRightIconTap,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leadingWidth: 56, // Explicitly set the width (default is 56)
    leading: leftIconPath != null
        ? leftIconPath == "assets/logo2.png"
              ? InkWell(
                  onTap: () {
                    Get.toNamed(Routes.HOME);
                  },
                  child: Center(
                    child: Image.asset(
                      leftIconPath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: Image.asset(
                      leftIconPath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
        : null,
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
      if (rightIconPath != null)
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onRightIconTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              rightIconPath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
        ),
    ],
  );
}

// Solution 2: Using SizedBox to force exact dimensions
PreferredSizeWidget appBarWithSizedBox({
  String? leftIconPath,
  String? rightIconPath,
  VoidCallback? onRightIconTap,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leading: leftIconPath != null
        ? InkWell(
            onTap: () {
              Get.back();
            },
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: Image.asset(leftIconPath, fit: BoxFit.contain),
              ),
            ),
          )
        : null,
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
      if (rightIconPath != null)
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onRightIconTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(rightIconPath, fit: BoxFit.contain),
            ),
          ),
        ),
    ],
  );
}

// Solution 3: Using IconButton for better control
PreferredSizeWidget appBarWithIconButton({
  String? leftIconPath,
  String? rightIconPath,
  VoidCallback? onRightIconTap,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leading: leftIconPath != null
        ? IconButton(
            icon: Image.asset(
              leftIconPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              Get.back();
            },
          )
        : null,
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
      if (rightIconPath != null)
        IconButton(
          icon: Image.asset(
            rightIconPath,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          onPressed: onRightIconTap,
        ),
    ],
  );
}
