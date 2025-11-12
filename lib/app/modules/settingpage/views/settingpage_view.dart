import 'package:eztrainz/app/modules/settingpage/controllers/settingpage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingpageView extends GetView<SettingsController> {
  const SettingpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/setting.png",
        onRightIconTap: () {
          Get.toNamed(Routes.SETTINGPAGE);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Learning'),
            const SizedBox(height: 8),
            _buildDropdownCard(
              label: 'Daily Goal',
              value: controller.dailyGoal,
              items: controller.dailyGoalOptions,
              onChanged: controller.updateDailyGoal,
            ),
            const SizedBox(height: 8),
            _buildDropdownCard(
              label: 'Weekly Goal',
              value: controller.weeklyGoal,
              items: controller.weeklyGoalOptions,
              onChanged: controller.updateWeeklyGoal,
            ),
            const SizedBox(height: 10),

            // Appearance Section
            _buildSectionHeader('Appearance'),
            const SizedBox(height: 8),
            _buildDropdownCard(
              label: 'Theme',
              value: controller.selectedTheme,
              items: controller.themeOptions,
              onChanged: controller.updateTheme,
            ),
            const SizedBox(height: 10),
            _buildSectionHeader('Account'),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'Edit Profile',
              onTap: controller.editProfile,
            ),
            const SizedBox(height: 8),
            _buildActionCard(label: 'Sign Out', onTap: controller.signOut),
            const SizedBox(height: 10),
            _buildSectionHeader('Support & Info'),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'Help Center',
              onTap: () {
                Get.snackbar('Help', 'Opening Help Center...');
              },
            ),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'Privacy Policy',
              onTap: () {
                Get.snackbar('Info', 'Opening Privacy Policy...');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdownCard({
    required String label,
    required RxString value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          Obx(
            () => DropdownButton<String>(
              value: value.value,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
