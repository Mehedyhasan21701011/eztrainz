import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/cardheading.dart';
import 'package:eztrainz/app/utils/widget/headingtext.dart';
import 'package:eztrainz/app/utils/widget/subtitle.dart';
import 'package:eztrainz/app/utils/widget/tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/learngrammer_controller.dart';

class LearngrammerView extends GetView<LearngrammerController> {
  const LearngrammerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.selectedIndex.value = 0,
                      child: buildTab(
                        "Structure",
                        controller.selectedIndex.value == 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.selectedIndex.value = 1,
                      child: buildTab(
                        "Verb",
                        controller.selectedIndex.value == 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.selectedIndex.value == 0) {
                  return _buildStructureContent(controller);
                } else {
                  return _buildVerbContent();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStructureContent(LearngrammerController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingText("Understand Japanese sentence structure."),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: controller.grammarCards.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final card = controller.grammarCards[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 225, 225),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cardHeading(card["title"].toString()),
                          const SizedBox(height: 4),
                          subTitle(card["description"].toString()),
                        ],
                      ),
                    ),
                    Image.asset("assets/rightArrow.png", width: 24, height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerbContent() {
    return const Center(
      child: Text(
        "Verb Lessons",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
