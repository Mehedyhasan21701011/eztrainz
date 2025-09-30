import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/verbdetails_controller.dart';

class VerbdetailsView extends GetView<VerbdetailsController> {
  const VerbdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/setting.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: SafeArea(
        child: Obx(() {
          final verb = controller
              .learngrammercontroller
              .currentPageItems[controller.verbId.value];

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildVerbCard(verb),
                _buildNavButtons(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// 🔹 Verb Card Widget
  Widget _buildVerbCard(verb) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Column(
                children: [
                  Text(
                    "${verb.kanji}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "(${verb.hiragana})",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${verb.english}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Explanation
            const Text(
              "Explanation",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              verb.explanation,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 32),

            // Conjugations
            const Text(
              "Conjugations",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Heading Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Form",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                      Text(
                        "Japanese",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                      Text(
                        "Meaning",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 🔹 Data Rows
                  ...verb.conjugations.map(
                    (example) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            example.form,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            example.japanese,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            example.meaning,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Navigation Buttons
  Widget _buildNavButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Obx(() {
        final isFirst = controller.verbId.value == 0;
        final isLast =
            controller.verbId.value ==
            controller.learngrammercontroller.currentPageItems.length - 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous Button
            OutlinedButton(
              onPressed: isFirst ? null : () => controller.verbId.value--,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(120, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: TColors.primary),
              ),
              child: Row(
                children: [
                  Image.asset("assets/leftArrow.png", width: 18, height: 18),
                  const SizedBox(width: 8),
                  Text("Previous", style: TextStyle(color: TColors.primary)),
                ],
              ),
            ),

            // Next Button
            OutlinedButton(
              onPressed: isLast ? null : () => controller.verbId.value++,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(120, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: TColors.primary),
              ),
              child: Row(
                children: [
                  Text("Next", style: TextStyle(color: TColors.primary)),
                  const SizedBox(width: 8),
                  Image.asset("assets/rightArrow.png", width: 18, height: 18),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
