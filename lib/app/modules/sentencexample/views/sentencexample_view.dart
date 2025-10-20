import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sentencexample_controller.dart';

class SentencexampleView extends GetView<SentencexampleController> {
  const SentencexampleView({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Learn more with examples',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Image.asset("assets/example.png", width: 24, height: 24),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Paginated list
            Expanded(
              child: Obx(() {
                final visibleExamples = controller.paginatedExamples;
                return ListView.builder(
                  itemCount: visibleExamples.length,
                  itemBuilder: (context, index) {
                    final example = visibleExamples[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: TColors.buttonBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Text(
                                  example.japanese,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                example.english,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 8),

            // 🔹 "See more" button
            Obx(() {
              return controller.hasMore
                  ? primaryButton(
                      'See more examples',
                      onTap: controller.nextPage,
                    )
                  : const Center(
                      child: Text(
                        'No more examples available.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
