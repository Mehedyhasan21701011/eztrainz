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
          final verb =
              controller.learngrammercontroller.verbs[controller.verbId.value];

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 4, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${verb.kanji}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "(${verb.hiragana})",
                    style: const TextStyle(
                      fontSize: 20,
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${verb.english}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Explanation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text(
                "Explanation",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                verb.explanation,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 24),

            // Polite Form
            _buildFormSection(
              title: "Polite Form",
              headers: const ["Tense", "Positive", "Negative"],
              rows: [
                [
                  "Present",
                  verb.politeForm.presentPositive,
                  verb.politeForm.presentNegative,
                ],
                [
                  "Past",
                  verb.politeForm.pastPositive,
                  verb.politeForm.pastNegative,
                ],
              ],
            ),

            const SizedBox(height: 24),

            // Plain Form
            _buildFormSection(
              title: "Plain Form",
              headers: const ["Tense", "Positive", "Negative"],
              rows: [
                [
                  "Present",
                  verb.plainForm.presentPositive,
                  verb.plainForm.presentNegative,
                ],
                [
                  "Past",
                  verb.plainForm.pastPositive,
                  verb.plainForm.pastNegative,
                ],
              ],
            ),

            const SizedBox(height: 24),

            // Te Form
            _buildFormSection(
              title: "Te Form",
              headers: const ["Usage", "Examples"],
              rows: [
                ["Connective", verb.teForm.connective],
                ["Request", verb.teForm.request],
                ["Progressive", verb.teForm.progressive],
              ],
              isTeForm: true,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Form Section Builder
  Widget _buildFormSection({
    required String title,
    required List<String> headers,
    required List<List<String>> rows,
    bool isTeForm = false,
  }) {
    return Column(
      children: [
        // Section Title
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Table Container
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: TColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header Row
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                decoration: BoxDecoration(
                  color: TColors.cardBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),

                child: Row(
                  children: headers.map((header) {
                    return Expanded(
                      flex: isTeForm && header == "Examples" ? 2 : 1,
                      child: Text(
                        header,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: header == headers.first
                            ? TextAlign.left
                            : TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: Colors.black),
              ),

              // Data Rows
              ...rows.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                final isLastRow = index == rows.length - 1;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: isLastRow
                          ? BorderSide.none
                          : BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: row.asMap().entries.map((cellEntry) {
                      final cellIndex = cellEntry.key;
                      final cell = cellEntry.value;

                      return Expanded(
                        flex: isTeForm && cellIndex == 1 ? 2 : 1,
                        child: Text(
                          cell,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: cellIndex == 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          textAlign: cellIndex == 0
                              ? TextAlign.left
                              : TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
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
            controller.learngrammercontroller.verbs.length - 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous Button
            OutlinedButton(
              onPressed: isFirst ? null : () => controller.verbId.value--,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(120, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: TColors.primary),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/leftArrow.png",
                    width: 18,
                    height: 18,
                    color: TColors.primary,
                  ),
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
                side: BorderSide(
                  color: isLast ? Colors.grey.shade300 : TColors.primary,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      color: isLast ? Colors.grey : TColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    "assets/rightArrow.png",
                    width: 18,
                    height: 18,
                    color: isLast ? Colors.grey : TColors.primary,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
