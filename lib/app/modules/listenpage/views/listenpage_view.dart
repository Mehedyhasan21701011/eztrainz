// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:eztrainz/app/modules/listenpage/controllers/listenpage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListenpageView extends GetView<ListenpageController> {
  const ListenpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: 'assets/leftArrow.png',
        rightIconPath: 'assets/profile.png',
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Listen to the audio and answer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset("assets/music.png", width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 80,
                        decoration: BoxDecoration(
                          color: TColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.audio[0]['title'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                      Text(
                        controller.audio[0]['subtitle'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      buildProgressbar(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous Button
                            GestureDetector(
                              onTap: controller.skipBackward,
                              child: Image.asset(
                                'assets/play_left.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const SizedBox(width: 60),

                            // Play Button
                            GestureDetector(
                              onTap: controller.togglePlayPause,
                              child: controller.isPlaying.value
                                  ? Image.asset(
                                      'assets/pause.png',
                                      width: 40,
                                      height: 40,
                                    )
                                  : Image.asset(
                                      'assets/play.png',
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                            const SizedBox(width: 60),
                            // Next Button
                            GestureDetector(
                              onTap:
                                  controller.skipForward, // 10 seconds forward
                              child: Image.asset(
                                'assets/play_right.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                buildChangeQuestion(),
                const SizedBox(height: 20),
                controller.showQuestion.value
                    ? buildQuestion()
                    : buildCongratulationSection(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: TColors.cardBackground,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        controller.showQuestion.value
                            ? 'Choose the right answer'
                            : 'Congratulations',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildProgressbar() {
    return Obx(() {
      final total = controller.totalDuration.value.inMilliseconds;
      final current = controller.currentPosition.value.inMilliseconds;

      // Avoid division by zero

      return Column(
        children: [
          Slider(
            value: current.toDouble(),
            min: 0,
            max: total.toDouble(),
            onChanged: (value) {
              controller.seekTo(value);
            },
            activeColor: Colors.blue,
            inactiveColor: TColors.questionBackground,
          ),
          // Time labels
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(_formatDuration(controller.currentPosition.value)),
          //       Text(_formatDuration(controller.totalDuration.value)),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }

  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '$minutes:$seconds';
  // }

  Widget buildCongratulationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/congratulations.png", width: 150, height: 150),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildQuestion() {
    final question = controller.question[controller.currentPage.value];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: TColors.questionBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                // ✅ Move it here
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    question['question'],
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Options
          ...List.generate(question['options'].length, (index) {
            final option = question['options'][index];
            final isSelected = controller.selectedAnswer.value == index;
            final isCorrect = controller.isCorrect(index);
            return GestureDetector(
              onTap: () {
                controller.selectAnswer(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : TColors.questionBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      '${String.fromCharCode(97 + index)})',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      // Better than Spacer for text wrapping
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Image.asset(
                        isCorrect ? "assets/right.png" : "assets/wrong.png",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildChangeQuestion() {
    return Obx(() {
      final int total = controller.question.length;
      final int currentIndex = controller.currentPage.value;

      int start = (currentIndex - 1).clamp(0, (total - 3).clamp(0, total));
      int end = (start + 3).clamp(0, total);
      final visibleIndexes = List.generate(end - start, (i) => start + i);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavButton(
              Icons.arrow_back_ios,
              controller.hasPreviousPage,
              controller.previousPage,
            ),
            ...visibleIndexes.map((index) => _buildPageIndicator(index)),
            buildNavButton(
              Icons.arrow_forward_ios,
              controller.hasNextPage,
              controller.nextPage,
            ),
          ],
        ),
      );
    });
  }

  Widget buildNavButton(IconData icon, bool isEnabled, VoidCallback? onTap) {
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
      onTap: () => controller.goToPage(index),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: controller.currentPage.value == index
            ? const Color(0xFFE1EFFD)
            : Colors.transparent,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color: controller.currentPage.value == index
                ? Colors.blue
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}
