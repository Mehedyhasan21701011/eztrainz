import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:flutter/material.dart';

Widget buildWordDialogWithoutAddIcon(Map<String, dynamic> word) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed size
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/tree.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    size: 24,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                children: [
                  // First row: Kanji and Hiragana
                  Row(
                    children: [
                      Expanded(child: buildWordRow("Kanji", word['kanji'])),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildWordRow("Hiragana", word['hiragana']),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: buildWordRow("Romaji", word['romaji'])),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildWordRow("Meaning", word['meaning']),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    
            const SizedBox(width: 8),
    
            GestureDetector(
              onTap: () {
                // Add your audio play logic here
                // controller.playAudio(word['audio']);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/mike.png",
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.volume_up,
                        size: 18,
                        color: Colors.blue,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
    
        const SizedBox(height: 16),
    
        // Sentence section
        if (word['sentence'] != null) buildSentence(word),
      ],
    ),
  );
}

Widget buildWordRow(String label, String? value, {bool isBold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: AppColors.titleStyle.copyWith(
          fontSize: 10,
          color: Colors.grey[600],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      const SizedBox(width: 2),
      Text(
        value ?? '',
        style: isBold
            ? AppColors.highlightStyle.copyWith(fontSize: 14)
            : AppColors.titleStyle.copyWith(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2, // Allow wrapping for longer content
        softWrap: true,
      ),
    ],
  );
}

Widget buildSentence(Map<String, dynamic> word) {
  final sentence = word['sentence'] as Map<String, dynamic>?;
  if (sentence == null) return const SizedBox.shrink();

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sentence['japanese'] ?? '',
            style: AppColors.highlightStyle.copyWith(fontSize: 16),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ],
      ),
      const SizedBox(height: 8),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (sentence['romaji']?.isNotEmpty == true) ...[
            Text(
              '${sentence['romaji']}',
              style: AppColors.titleStyle.copyWith(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
            const SizedBox(height: 4),
          ],
          if (sentence['english']?.isNotEmpty == true) ...[
            Text(
              '${sentence['english']}',
              style: AppColors.titleStyle.copyWith(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ],
        ],
      ),
    ],
  );
}
