import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:flutter/material.dart';

Widget buildWordDetails(Map<String, dynamic> word) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildWordRow("Kanji", word['kanji']),
          buildWordRow("Romaji", word['romaji']),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildWordRow("Hiragana", word['hiragana']),
          buildWordRow("Meaning", word['meaning']),
        ],
      ),
      GestureDetector(
        // onTap: controller.playAudio,
        child: Image.asset("assets/mike.png", width: 24, height: 24),
      ),
    ],
  );
}

Widget buildWordRow(String label, String? value, {bool isBold = false}) {
  return Row(
    children: [
      Text(label, style: AppColors.titleStyle),
      SizedBox(width: 10),
      Text(
        value ?? '',
        style: isBold
            ? AppColors.highlightStyle
            : AppColors.titleStyle.copyWith(color: Colors.blue),
      ),
    ],
  );
}

Widget buildSentence(Map<String, dynamic> word) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 10),
      Text(word['sentence']['japanese'] ?? '', style: AppColors.highlightStyle),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(word['sentence']['romaji'] ?? '', style: AppColors.titleStyle),
          Text(word['sentence']['english'] ?? '', style: AppColors.titleStyle),
        ],
      ),
    ],
  );
}
