import 'package:eztrainz/app/modules/profilepage/controllers/profilepage_controller.dart';
import 'package:eztrainz/app/utils/constraint/colors.dart';
import 'package:eztrainz/app/utils/widget/appbarwitharrowandsetting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithArrowAndSetting(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildProgressSection(),
            const SizedBox(height: 10),
            _buildStatsRow(),
            const SizedBox(height: 30),
            _buildWeeklyStudyChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Profile Picture with Border
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.brown.shade200,
                backgroundImage: const AssetImage("assets/person.png"),
              ),
            ),

            Positioned(
              bottom: -10,
              right: 40,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset("assets/edit.png", height: 28, width: 28),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  controller.userName.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Image.asset("assets/madel.png", height: 22, width: 22),
            ],
          ),
        ),

        // Email
        Obx(
          () => Text(
            controller.userEmail.value,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Level',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        "assets/dropdown.png",
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        controller.userLevel.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryButtonBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Obx(
                  () => Container(
                    height: 8,
                    width:
                        MediaQuery.of(Get.context!).size.width *
                        (controller.progressPercentage.value / 100) *
                        0.7,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Obx(
                () => Text(
                  controller.formattedProgress,
                  style: const TextStyle(fontSize: 16, color: AppColor.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // ✅ Makes children take full width
      children: [
        _buildStatCard(
          'Lessons Done',
          () => controller.lessonsDone.value.toString(),
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          'Games Completed',
          () => controller.gamesCompleted.value.toString(),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String Function() getValue) {
    return Container(
      width: double.infinity, // ✅ Forces full width
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
            () => Text(
              getValue(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStudyChart() {
    return GetX<ProfileController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Study Record',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            controller.weekDays[value.toInt()],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}h',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: controller.weeklyStudyData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
