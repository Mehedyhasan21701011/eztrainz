import 'package:eztrainz/app/modules/common/youtube.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString selectedLevel = "N1".obs;
  final Rxn<int> expandedIndex = Rxn<int>();
  final RxList<Map<String, dynamic>> lessons = <Map<String, dynamic>>[].obs;
  final RxString videoUrl = "".obs;

  /// Full lesson data for all levels
  final Map<String, List<Map<String, dynamic>>> allLessons = {
    "N1": [
      {
        "title": "Introduction to N1",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/tLZjL-dMH_g",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/amTmnnqQf_E",
            "watched": false,
            "title": "Vucabolary Grammer",
          },
          {
            "url": "https://www.youtube.com/shorts/WNcizMEGL6w",
            "watched": false,
            "title": "Listening Practice",
          },
        ],
      },
      {
        "title": "Basic Grammar N1",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/WNcizMEGL6w",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/abc456",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
      {
        "title": "Bocabolary N1",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/abc123",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/abc456",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
    ],
    "N2": [
      {
        "title": "Introduction to N2",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n2a",
            "watched": false,
            "title": "kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n2b",
            "watched": false,
            "title": "kanji",
          },
        ],
      },
      {
        "title": "Grammar Practice N2",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n2c",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n2d",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n2e",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
      {
        "title": "Vocabulary N2",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n2f",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n2g",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
    ],
    "N3": [
      {
        "title": "Introduction to N3",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n3a",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n3b",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
      {
        "title": "Grammar Practice N3",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n3c",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n3d",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
      {
        "title": "Vocabulary N3",
        "progress": 0.0,
        "content": [
          {
            "url": "https://www.youtube.com/shorts/n3e",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n3f",
            "watched": false,
            "title": "Kanji",
          },
          {
            "url": "https://www.youtube.com/shorts/n3g",
            "watched": false,
            "title": "Kanji",
          },
        ],
      },
    ],
  };

  void onInit() {
    super.onInit();
    // Load default lessons (N1)
    lessons.assignAll(allLessons[selectedLevel.value]!);
  }

  void toggleExpand(int? index) {
    if (index == null) {
      expandedIndex.value = null;
      return;
    }
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }

  void changeLevel(String level) {
    selectedLevel.value = level;
    expandedIndex.value = null;
    lessons.assignAll(allLessons[level]!); // Update lessons list
  }

  double getProgressForLesson(int lessonIndex) {
    final lesson = lessons[lessonIndex];
    final content = lesson["content"] as List?;
    if (content == null || content.isEmpty) return 0.0;
    return lesson["progress"] as double? ?? 0.0;
  }
}
