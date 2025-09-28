import 'package:eztrainz/app/utils/constraint/colors.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final userName = 'John Doe'.obs;
  final userEmail = 'johndoe@gmail.com'.obs;
  final userLevel = 'N5'.obs;
  final progressPercentage = 70.0.obs;
  final lessonsDone = 5.obs;
  final gamesCompleted = 25.obs;

  // Weekly study data
  final weeklyStudyData = <BarChartGroupData>[].obs;
  final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void onInit() {
    super.onInit();
    initializeWeeklyData();
  }

  void initializeWeeklyData() {
    // Sample weekly study data (hours)
    final studyHours = [2.0, 3.0, 2.5, 3.5, 2.7, 1.5, 1.8];

    weeklyStudyData.value = studyHours.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: _getBarColor(entry.value),
            width: 16,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
              bottom: Radius.circular(8),
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _getBarColor(double value) {
    return AppColor.primary;
  }

  // Methods to update data
  void updateProgress(double newProgress) {
    progressPercentage.value = newProgress;
  }

  void incrementLessons() {
    lessonsDone.value++;
  }

  void incrementGames() {
    gamesCompleted.value++;
  }

  void updateUserInfo(String name, String email) {
    userName.value = name;
    userEmail.value = email;
  }

  void updateLevel(String level) {
    userLevel.value = level;
  }

  // Getter for formatted progress
  String get formattedProgress => '${progressPercentage.value.toInt()}%';

  // Method to get study hours for a specific day
  double getStudyHoursForDay(int dayIndex) {
    if (dayIndex < weeklyStudyData.length) {
      return weeklyStudyData[dayIndex].barRods.first.toY;
    }
    return 0.0;
  }
}
