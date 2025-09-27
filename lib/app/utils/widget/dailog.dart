import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future buildDialogBox() {
  return Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add to Favorites'),
      content: const Text('Do you want to add this word to your favorites?'),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: Get.back,
          child: const Text('Add', style: TextStyle(color: Colors.blue)),
        ),
      ],
    ),
  );
}
