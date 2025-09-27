import 'package:eztrainz/app/modules/vocabolarygrammer/controllers/vocabolarygrammer_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/addbutton.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/buildworddialogbox.dart';
import 'package:eztrainz/app/utils/widget/dailog.dart';
import 'package:eztrainz/app/utils/widget/headingtext.dart';
import 'package:eztrainz/app/utils/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VocabolaryView extends GetView<VocabolaryController> {
  const VocabolaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(),
      body: ListView(
        padding: EdgeInsets.zero, // cleaner
        children: [
          _buildTabSection(),
          _buildVideoSection(),
          Obx(() {
            return controller.selectedTab.value == "Grammar"
                ? _buildGrammer()
                : _buildVocabolary();
          }),
        ],
      ),
    );
  }

  Widget _buildGrammer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          headingText("Master Japanese Grammar with Easy Steps"),
          SizedBox(height: 8),
          buildCard(
            "assets/tree.png",
            "Learn Grammar",
            "Understand grammar, particles, and sentence structures",
            "Start",
          ),
          buildCard(
            "assets/tree.png",
            "Practice Grammar",
            "Review Key Grammar pointswith example",
            "Practice",
          ),
        ],
      ),
    );
  }

  Widget _buildVocabolary() {
    return Column(
      children: [
        _buildTodaysWordsSection(),
        _buildChangeWordButton(),
        _buildExploreMoreSection(),
      ],
    );
  }

  //grammer section
  Widget buildCard(
    String url,
    String title,
    String subtitle,
    String buttonText,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.buttonBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    url,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(1),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  buttonText == "Start"
                      ? Get.toNamed(Routes.LEARNGRAMMER)
                      : Get.toNamed(Routes.PRACTICEGRAMMER);
                },
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //vocabolary section
  Widget _buildTabSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => _buildTab(
                "Grammar",
                controller.selectedTab.value == "Grammar",
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Obx(
              () => _buildTab(
                "Vocabulary",
                controller.selectedTab.value == "Vocabulary",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => controller.selectTab(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF6F585) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.yellow.withOpacity(0.5), width: 1),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF3193F5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSection() {
    return GetBuilder<VocabolaryController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: controller.ytController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.blueAccent,
                handleColor: Colors.blueAccent,
              ),
            ),
            builder: (context, player) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(aspectRatio: 16 / 9, child: player),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTodaysWordsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          headingText("Today's Words"),
          const SizedBox(height: 4),
          Obx(() {
            if (controller.todaysWords.isEmpty) return const SizedBox.shrink();

            final currentWord = controller.getCurrentWord();
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.blue[100],
                          child: Image.asset(
                            "assets/tree.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: buildWordDetails(currentWord)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (currentWord['sentence'] != null)
                    buildSentence(currentWord),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [_buildAddToFavoritesButton()],
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Widget buildWordDetails(Map<String, dynamic> word) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           buildWordRow("Kanji", word['kanji']),
  //           buildWordRow("Romaji", word['romaji']),
  //         ],
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           buildWordRow("Hiragana", word['hiragana']),
  //           buildWordRow("Meaning", word['meaning']),
  //         ],
  //       ),
  //       GestureDetector(
  //         onTap: controller.playAudio,
  //         child: Image.asset("assets/mike.png", width: 24, height: 24),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildWordRow(String label, String? value, {bool isBold = false}) {
  //   return Row(
  //     children: [
  //       Text(label, style: _titleStyle),
  //       SizedBox(width: 10),
  //       Text(
  //         value ?? '',
  //         style: isBold
  //             ? _highlightStyle
  //             : _titleStyle.copyWith(color: Colors.blue),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildSentence(Map<String, dynamic> word) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       const SizedBox(height: 10),
  //       Text(word['sentence']['japanese'] ?? '', style: _highlightStyle),
  //       const SizedBox(height: 10),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(word['sentence']['romaji'] ?? '', style: _titleStyle),
  //           Text(word['sentence']['english'] ?? '', style: _titleStyle),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildAddToFavoritesButton() {
    return GestureDetector(
      onTap: () {
        buildDialogBox();
      },
      child: buildAddButton(),
    );
  }

  Widget _buildChangeWordButton() {
    return Obx(() {
      final int total = controller.todaysWords.length;
      final int currentIndex = controller.currentWordIndex.value;

      int start = (currentIndex - 1).clamp(0, (total - 3).clamp(0, total));
      int end = (start + 3).clamp(0, total);
      final visibleIndexes = List.generate(end - start, (i) => start + i);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(
              Icons.arrow_back_ios,
              controller.hasPreviousWord,
              controller.previousWord,
            ),
            ...visibleIndexes.map((index) => _buildPageIndicator(index)),
            _buildNavButton(
              Icons.arrow_forward_ios,
              controller.hasNextWord,
              controller.nextWord,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNavButton(IconData icon, bool isEnabled, VoidCallback? onTap) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      customBorder: const CircleBorder(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.only(left: 5),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isEnabled ? Colors.blue : Colors.grey),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return GestureDetector(
      onTap: () => controller.goToWord(index),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: controller.currentWordIndex.value == index
            ? const Color(0xFFE1EFFD)
            : Colors.transparent,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color: controller.currentWordIndex.value == index
                ? Colors.blue
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildExploreMoreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: headingText("Explore More")),
              buildSearch(),
            ],
          ),
          const SizedBox(height: 12),
          _buildCategoryList(),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.exploreMore.length,
        itemBuilder: (context, index) {
          final category = controller.exploreMore[index];
          return Obx(
            () => GestureDetector(
              onTap: () {
                controller.SelectedCategory.value = category['category'];
                Get.toNamed(Routes.WORDPAGE);
              },
              child: Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:
                      controller.SelectedCategory.value == category['category']
                      ? const Color(0xFFF6F585)
                      : const Color(0xFFE1EFFD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['category'] ?? '',
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category['japanese'] ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
