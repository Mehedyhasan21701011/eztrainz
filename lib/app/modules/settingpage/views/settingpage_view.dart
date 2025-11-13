import 'package:eztrainz/app/modules/settingpage/controllers/settingpage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/service/translatedText.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eztrainz/app/service/translatorcontroller.dart';

class SettingpageView extends GetView<SettingsController> {
  const SettingpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langCtrl = Get.find<LanguageController>(); // 🔥 Language controller

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
        padding: const EdgeInsets.all(32.0),
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
            _buildDropdownCard(
              label: 'Weekly Goal',
              value: controller.weeklyGoal,
              items: controller.weeklyGoalOptions,
              onChanged: controller.updateWeeklyGoal,
            ),
            const SizedBox(height: 10),
            _buildSectionHeader('Appearance'),
            _buildDropdownCard(
              label: 'Theme',
              value: controller.selectedTheme,
              items: controller.themeOptions,
              onChanged: controller.updateTheme,
            ),
            const SizedBox(height: 10),
            _buildActionCard(
              label: 'Language',
              onTap: () {
                langCtrl.currentLang.value = langCtrl.currentLang.value == 'en'
                    ? 'bn'
                    : 'en';
                Get.snackbar(
                  'Language Changed',
                  langCtrl.currentLang.value == 'en' ? 'English' : 'বাংলা',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              trailing: Obx(
                () => Text(
                  langCtrl.currentLang.value == 'en' ? 'EN' : 'বাংলা',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            _buildSectionHeader('Account'),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'Edit Profile',
              onTap: controller.editProfile,
            ),
            _buildActionCard(label: 'Sign Out', onTap: controller.signOut),
            const SizedBox(height: 10),
            _buildSectionHeader('Support & Info'),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'About us',
              onTap: () {
                Get.snackbar('Help', 'Opening Help Center...');
              },
            ),
            const SizedBox(height: 8),
            _buildActionCard(
              label: 'FQ',
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
      child: TranslatedText(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(221, 24, 24, 24),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
          Obx(
            () => DropdownButton<String>(
              value: value.value,
              underline: const SizedBox(),
              icon: const SizedBox.shrink(),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 40,
                      ),
                      Text(item, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
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
    Widget? trailing,
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
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
