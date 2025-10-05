import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:flutter/material.dart';

Widget buildWordDialogWithoutAddIcon(Map<String, dynamic> word) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 500),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Word Header Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/tree.png",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Word Details - Flexible layout
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kanji and Hiragana row
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        buildWordRow("Kanji", word['kanji']),
                        buildWordRow("Hiragana", word['hiragana'] ?? ''),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Romaji and Meaning row
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        buildWordRow("Romaji", word['romaji'] ?? ''),
                        buildWordRow("Meaning", word['meaning'] ?? ''),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Audio button
              GestureDetector(
                onTap: () {
                  // Add audio play functionality
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.volume_up,
                    size: 18,
                    color: Colors.blue,
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
    ),
  );
}

Widget buildWordRow(String label, String? value, {bool isBold = false}) {
  return IntrinsicWidth(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppColors.titleStyle.copyWith(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60, maxWidth: 150),
          child: Text(
            value ?? '',
            style: isBold
                ? AppColors.highlightStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )
                : AppColors.titleStyle.copyWith(
                    color: Colors.blue[800],
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ),
  );
}

Widget buildSentence(Map<String, dynamic> word) {
  final sentence = word['sentence'] as Map<String, dynamic>?;
  if (sentence == null) return const SizedBox.shrink();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Japanese sentence
      Center(
        child: Text(
          sentence['japanese'] ?? '',
          style: AppColors.highlightStyle.copyWith(fontSize: 16),
          softWrap: true,
          maxLines: null,
        ),
      ),
      const SizedBox(height: 8),

      // Romaji + English in a row, each wrapped
      Row(
        children: [
          if (sentence['romaji']?.isNotEmpty == true)
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                sentence['romaji']!,
                style: AppColors.titleStyle.copyWith(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                softWrap: true,
                maxLines: null,
              ),
            ),
          const SizedBox(width: 8),
          if (sentence['english']?.isNotEmpty == true)
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                sentence['english']!,
                style: AppColors.titleStyle.copyWith(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                softWrap: true,
                maxLines: null,
              ),
            ),
        ],
      ),
    ],
  );
}
