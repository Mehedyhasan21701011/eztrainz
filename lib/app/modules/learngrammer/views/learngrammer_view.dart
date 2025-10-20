import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/cardheading.dart';
import 'package:eztrainz/app/utils/widget/heading2.dart';
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
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/profile.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headingText("Understand Japanese sentence structure."),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: controller.grammarCards.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final card = controller.grammarCards[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Get.toNamed(Routes.PARTICLEPAGE);
                  } else if (index == 4) {
                    Get.toNamed(Routes.SENTENCE);
                  } else if (index == 1) {
                    Get.toNamed(Routes.NOUNPRONOUN);
                  } else if (index == 2) {
                    Get.toNamed(Routes.ADJECTIVE);
                  } else if (index == 3) {
                    Get.toNamed(Routes.ADVERB);
                  }
                },
                child: Container(
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
                      Image.asset(
                        "assets/rightArrow.png",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerbContent() {
    return Column(
      children: [
        heading2("Let’s get Handy with verbs & Conjugations!"),
        const SizedBox(height: 8),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = controller.currentPageItems;

            if (items.isEmpty) {
              return _buildEmptyState();
            }

            return GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final verb = items[index];
                return _buildVerbCard(verb, index);
              },
            );
          }),
        ),
        const SizedBox(height: 8),
        Obx(() => _buildPaginationControls()),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No verbs found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: controller.clearSearch,
            child: const Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerbCard(Verb verb, int index) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.VERBDETAILS, arguments: index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                verb.english,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                verb.kanji,
                style: const TextStyle(fontSize: 16, color: TColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                "${verb.hiragana}    ${verb.romaji}",
                style: const TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        controller.hasPreviousPage
            ? TextButton.icon(
                onPressed: controller.previousPage,
                icon: const Icon(Icons.arrow_back_ios, size: 16),
                label: const Text("Previous"),
                style: TextButton.styleFrom(foregroundColor: TColors.primary),
              )
            : const SizedBox.shrink(),

        controller.hasNextPage
            ? TextButton.icon(
                onPressed: controller.nextPage,
                label: const Text("Next"),
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                style: TextButton.styleFrom(foregroundColor: TColors.primary),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
