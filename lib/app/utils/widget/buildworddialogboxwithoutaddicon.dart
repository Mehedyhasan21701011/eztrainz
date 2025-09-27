import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:flutter/material.dart';

Widget buildWordDialogWithoutAddIcon(Map<String, dynamic> word) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      minHeight: 150,
      maxHeight: 300, // Prevent excessive height
    ),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with image and word details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with fixed size
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
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
                ),
                const SizedBox(width: 12),

                // Word details - flexible layout
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

                      // Second row: Romaji and Meaning
                      Row(
                        children: [
                          Expanded(
                            child: buildWordRow("Romaji", word['romaji']),
                          ),
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

                // Audio button
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
      ),
    ),
  );
}

Widget buildWordRow(String label, String? value, {bool isBold = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
      const SizedBox(height: 2),
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

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Japanese sentence
        Text(
          sentence['japanese'] ?? '',
          style: AppColors.highlightStyle.copyWith(fontSize: 16),
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
        const SizedBox(height: 8),

        // Romaji and English
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sentence['romaji']?.isNotEmpty == true) ...[
              Text(
                'Romaji: ${sentence['romaji']}',
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
                'English: ${sentence['english']}',
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
    ),
  );
}

// Alternative version with even more overflow protection
Widget buildWordDialogWithoutAddIconSafe(Map<String, dynamic> word) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 150,
      maxHeight: 350,
      maxWidth: 400,
    ),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with image and word details
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image container
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/tree.png",
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
                  ),

                  const SizedBox(width: 12),

                  // Word details
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCompactWordInfo(word, constraints.maxWidth),
                          ],
                        );
                      },
                    ),
                  ),

                  // Audio button
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add audio functionality
                      },
                      icon: const Icon(Icons.volume_up, size: 16),
                      color: Colors.blue,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Sentence section
            if (word['sentence'] != null) buildCompactSentence(word),
          ],
        ),
      ),
    ),
  );
}

Widget buildCompactWordInfo(Map<String, dynamic> word, double maxWidth) {
  return Wrap(
    spacing: 8,
    runSpacing: 4,
    children: [
      buildInfoChip("Kanji", word['kanji'], Colors.orange),
      buildInfoChip("Hiragana", word['hiragana'], Colors.blue),
      buildInfoChip("Romaji", word['romaji'], Colors.green),
      buildInfoChip("Meaning", word['meaning'], Colors.purple),
    ],
  );
}

Widget buildInfoChip(String label, String? value, Color color) {
  if (value?.isEmpty ?? true) return const SizedBox.shrink();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black87),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: value!,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}

Widget buildCompactSentence(Map<String, dynamic> word) {
  final sentence = word['sentence'] as Map<String, dynamic>?;
  if (sentence == null) return const SizedBox.shrink();

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sentence['japanese'] ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          softWrap: true,
        ),
        if (sentence['romaji']?.isNotEmpty == true) ...[
          const SizedBox(height: 6),
          Text(
            sentence['romaji']!,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            softWrap: true,
          ),
        ],
        if (sentence['english']?.isNotEmpty == true) ...[
          const SizedBox(height: 6),
          Text(
            sentence['english']!,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            softWrap: true,
          ),
        ],
      ],
    ),
  );
}
