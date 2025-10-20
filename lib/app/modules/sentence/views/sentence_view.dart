import 'package:eztrainz/app/modules/sentence/controllers/sentence_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentenceView extends GetView<SentenceController> {
  const SentenceView({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Sentence Foundation',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              'Japanese sentence structure follows a clear pattern where the verb always comes last.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4), // shadow color
                    spreadRadius: 0, // minimal spread
                    blurRadius: 5, // blur effect
                    offset: const Offset(0, 4), // moves shadow downwards only
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildWordStructure(),
                  const SizedBox(height: 24),
                  _buildSentenceDisplay(),
                  const SizedBox(height: 24),
                  _buildWordSelectionBlocks(),
                ],
              ),
            ),

            const SizedBox(height: 32),
            _buildExamplesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWordStructure() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildWordRow('主語', '目的語', '動詞', TColors.buttonBackground),
        const SizedBox(height: 8),
        _buildWordRow('しゅご', 'もくてきご', 'どうし', TColors.buttonBackground),
        const SizedBox(height: 8),
        _buildWordRow('Subject', 'Object', 'Verb', TColors.buttonBackground),
      ],
    );
  }

  Widget _buildWordRow(String first, String second, String third, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: _buildStaticWordBlock(first, color)),
        const SizedBox(width: 4),
        const Icon(Icons.add, size: 18, color: Colors.black),
        const SizedBox(width: 4),
        Expanded(child: _buildStaticWordBlock(second, color)),
        const SizedBox(width: 4),
        const Icon(Icons.add, size: 18, color: Colors.black),
        const SizedBox(width: 4),
        Expanded(child: _buildStaticWordBlock(third, color)),
      ],
    );
  }

  Widget _buildStaticWordBlock(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildSentenceDisplay() {
    return Obx(
      () => Center(
        child: Column(
          children: [
            Text(
              controller.currentSentence.value.isEmpty
                  ? '私はごはんを食べます。'
                  : controller.currentSentence.value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: TColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.currentSentence.value.isEmpty
                  ? 'わたしはごはんをたべます。'
                  : '${controller.selectedWords.isNotEmpty ? controller.selectedWords[0].romaji : ''}${controller.selectedWords.length > 1 ? controller.selectedWords[1].romaji : ''}を${controller.selectedWords.length > 2 ? controller.selectedWords[2].romaji : ''}。',
              style: const TextStyle(fontSize: 14, color: TColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              controller.currentTranslation.value.isEmpty
                  ? 'I eat rice.'
                  : controller.currentTranslation.value,
              style: const TextStyle(fontSize: 14, color: TColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordSelectionBlocks() {
    return Obx(
      () => Column(
        children: [
          _buildWordRow(
            controller.selectedWords.isNotEmpty
                ? controller.selectedWords[0].japanese
                : '私は',
            controller.selectedWords.length > 1
                ? controller.selectedWords[1].japanese
                : 'ごはん',
            controller.selectedWords.length > 2
                ? controller.selectedWords[2].japanese
                : '食べます',
            TColors.buttonSecondary,
          ),
          const SizedBox(height: 16),
          _buildWordRow(
            controller.selectedWords.isNotEmpty
                ? controller.selectedWords[0].romaji
                : 'わたしは',
            controller.selectedWords.length > 1
                ? controller.selectedWords[1].romaji
                : 'ごはん',
            controller.selectedWords.length > 2
                ? controller.selectedWords[2].romaji
                : 'たべます',
            TColors.buttonSecondary,
          ),
          const SizedBox(height: 16),
          _buildWordRow(
            controller.selectedWords.isNotEmpty
                ? controller.selectedWords[0].english
                : 'I',
            controller.selectedWords.length > 1
                ? controller.selectedWords[1].english
                : 'rice',
            controller.selectedWords.length > 2
                ? controller.selectedWords[2].english
                : 'eat',
            TColors.buttonSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Learn more with examples',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Image.asset("assets/example.png", width: 24, height: 24),
          ],
        ),
        const SizedBox(height: 16),
        Obx(
          () => Column(
            children: controller.examples.map((example) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TColors.buttonBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        primaryButton(
          'See more examples',
          onTap: () {
            Get.toNamed(Routes.SENTENCEXAMPLE);
          },
        ),
      ],
    );
  }
}
