import 'package:eztrainz/app/modules/wordpage/controllers/wordpage_controller.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/addbutton.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/dailog.dart';
import 'package:eztrainz/app/utils/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordpageView extends GetView<WordpageController> {
  const WordpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(),
      body: SafeArea(
        child: Column(
          children: [
            // Title & Search
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${controller.vgController.SelectedCategory}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black.withOpacity(.80),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildSearch(),
                ],
              ),
            ),

            // Word List
            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: controller.filteredWords.map((word) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryButton,
                          borderRadius: BorderRadius.circular(
                            24,
                          ), // ✅ control radius here
                          border: Border.all(
                            color: Colors.transparent, // ✅ remove border
                            width: 0,
                          ),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),

            // Add New Word Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add a new word",
                      style: TextStyle(fontSize: 18, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        buildDialogBox();
                      },
                      child: buildAddButton(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddWordDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text("Add New Word"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Enter word"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                controller.addWord(textController.text);
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
