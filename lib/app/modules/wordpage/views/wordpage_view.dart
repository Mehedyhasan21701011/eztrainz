import 'package:eztrainz/app/modules/wordpage/controllers/wordpage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/buildworddialogboxwithoutaddicon.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:eztrainz/app/utils/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordpageView extends GetView<WordpageController> {
  const WordpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/profile.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
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
                      final meaning = word['meaning'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: AppColors.cardBackground,
                              contentPadding: const EdgeInsets.all(16),
                              content: SizedBox(
                                width:
                                    Get.width *
                                    0.9, // ⬅️ set custom dialog width here
                                child: buildWordDialogWithoutAddIcon(word),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryButton,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                meaning,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: primaryButton(
                "Add a new word",
                imgPath: "assets/add.png",
                onTap: () {
                  buildDialogBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
