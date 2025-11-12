import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString selectedLevel = "N5".obs; // Fixed: Changed from "N" to "N1"
  final RxBool levelVisible = true.obs;
  final Rxn<int> expandedIndex = Rxn<int>();
  final RxList<Map<String, dynamic>> lessons = <Map<String, dynamic>>[].obs;
  final RxString videoUrl = "".obs;
  final RxString querydata = "".obs;
  var isSearchActive = false.obs;

  /// Full lesson data for all levels
  final Map<String, List<Map<String, dynamic>>> allLessons = {
    "N5": [
      {
        "title": "Introduction to N5",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Vocabulary & Grammar", "progress": 0.0},
          {"watched": false, "title": "Listening Practice", "progress": 0.0},
        ],
      },
      {
        "title": "Introduction to N5",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
      {
        "title": "Introduction to N5",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
    ],
    "N4": [
      {
        "title": "Introduction to N4",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "kanji", "progress": 0.0},
          {"watched": false, "title": "kanji", "progress": 0.0},
        ],
      },
      {
        "title": "Grammar Practice N4",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
      {
        "title": "Vocabulary N4",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
    ],
    "N3": [
      {
        "title": "Introduction to N3",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
      {
        "title": "Grammar Practice N3",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
      {
        "title": "Vocabulary N3",
        "progress": 0.0,
        "content": [
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
          {"watched": false, "title": "Kanji", "progress": 0.0},
        ],
      },
    ],
  };

  @override
  void onInit() {
    super.onInit();
    if (!allLessons.containsKey(selectedLevel.value)) {
      selectedLevel.value = "N5";
    }
    lessons.assignAll(allLessons[selectedLevel.value] ?? []);
  }

  void toggleExpand(int? index) {
    if (index == null) {
      expandedIndex.value = null;
      return;
    }
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }

  void filterWords(String value) {
    querydata.value = value.trim();
    isSearchActive.value = false;
    searchQuery();
  }

  void setSearchActive() {
    isSearchActive.value = true;
    levelVisible.value = false;
  }

  void searchQuery() {
    final query = querydata.value.toLowerCase();
    if (query.isEmpty) {
      lessons.assignAll(allLessons[selectedLevel.value] ?? []);
      return;
    }

    final allLessonsForLevel = allLessons[selectedLevel.value] ?? [];
    final filtered = allLessonsForLevel.where((lesson) {
      final title = (lesson["title"] as String? ?? "").toLowerCase();
      return title.contains(query);
    }).toList();

    lessons.assignAll(filtered);
    expandedIndex.value = null;
  }

  void changeLevel(String level) {
    if (!allLessons.containsKey(level)) return;

    selectedLevel.value = level;
    expandedIndex.value = null;
    lessons.assignAll(
      allLessons[level] ?? [],
    ); // Update lessons list with safety
  }

  double getProgressForLesson(int lessonIndex) {
    if (lessonIndex < 0 || lessonIndex >= lessons.length) return 0.0;

    final lesson = lessons[lessonIndex];
    final content = lesson["content"] as List?;
    if (content == null || content.isEmpty) return 0.0;
    if (lessonIndex == 0) return 0.7;
    return lesson["progress"] as double? ?? 0.0;
  }

  List<String> get availableLevels => allLessons.keys.toList();
  bool isValidLevel(String level) => allLessons.containsKey(level);
  int get currentLevelLessonCount => lessons.length;

  /// Set video URL
  void setVideoUrl(String url) {
    videoUrl.value = url;
  }

  /// Mark content as watched
  void markContentAsWatched(int lessonIndex, int contentIndex) {
    if (lessonIndex < 0 || lessonIndex >= lessons.length) return;

    final lesson = lessons[lessonIndex];
    final content = lesson["content"] as List?;

    if (content == null || contentIndex < 0 || contentIndex >= content.length) {
      return;
    }

    // Mark as watched
    content[contentIndex]["watched"] = true;
    content[contentIndex]["progress"] = 1.0;

    // Update lesson progress
    _updateLessonProgress(lessonIndex);

    // Trigger UI update
    lessons.refresh();
  }

  /// Update lesson progress based on watched content
  void _updateLessonProgress(int lessonIndex) {
    if (lessonIndex < 0 || lessonIndex >= lessons.length) return;

    final lesson = lessons[lessonIndex];
    final content = lesson["content"] as List?;

    if (content == null || content.isEmpty) return;

    final watchedCount = content
        .where((item) => item["watched"] == true)
        .length;
    final totalCount = content.length;

    lesson["progress"] = watchedCount / totalCount;
  }

  /// Get overall progress for current level
  double get overallProgress {
    if (lessons.isEmpty) return 0.0;

    double totalProgress = 0.0;
    for (final lesson in lessons) {
      totalProgress += (lesson["progress"] as double? ?? 0.0);
    }

    return totalProgress / lessons.length;
  }
}
