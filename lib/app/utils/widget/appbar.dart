import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appBar({
  String? leftIconPath,
  String? rightIconPath,
  VoidCallback? onRightIconTap,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    leading: InkWell(
      onTap: () {
        Get.back();
      },
      child: leftIconPath != null
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                leftIconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            )
          : const SizedBox(),
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
