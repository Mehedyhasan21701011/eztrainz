import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Learning Goals
  final RxString dailyGoal = '30 mins'.obs;
  final RxString weeklyGoal = '3 Hours'.obs;

  // Dropdown options
  final List<String> dailyGoalOptions = [
    '15 mins',
    '30 mins',
    '45 mins',
    '1 Hour',
    '2 Hours',
  ];

  final List<String> weeklyGoalOptions = [
    '1 Hour',
    '2 Hours',
    '3 Hours',
    '5 Hours',
    '10 Hours',
  ];

  // Appearance theme
  final RxString selectedTheme = 'Light'.obs;
  final List<String> themeOptions = ['Light', 'Dark', 'System'];

  // Methods
  void updateDailyGoal(String? value) {
    if (value != null) {
      dailyGoal.value = value;
      // TODO: Save to backend/local storage
    }
  }

  void updateWeeklyGoal(String? value) {
    if (value != null) {
      weeklyGoal.value = value;
      // TODO: Save to backend/local storage
    }
  }

  void updateTheme(String? value) {
    if (value != null) {
      selectedTheme.value = value;
      // TODO: Apply theme change
    }
  }

  void editProfile() {
    Get.toNamed('/edit-profile');
  }

  void signOut() {
    Get.dialog(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement sign out logic
              Get.offAllNamed('/login');
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}