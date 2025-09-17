import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListContentController extends GetxController {
  final RxString currentKanji = '山'.obs;
  final RxString kanjiMeaning = 'Mountain'.obs;
  final RxString kunyomi = 'やま / Yama'.obs;
  final RxString onyomi = 'サン / San'.obs;
  final RxBool isVideoPlaying = false.obs;
  final RxString lessonTitle = 'Kanji Lesson 1'.obs;
  final RxString selectedKanji = ''.obs;
  final RxInt currentLessonIndex = 0.obs;
  final RxBool isLoading = false.obs;

  final RxList<String> kanjiOptions = <String>['国', '年', '本', '中'].obs;

  // Sample lesson data
  final List<Map<String, dynamic>> lessons = [
    {
      'kanji': '山',
      'meaning': 'Mountain',
      'kunyomi': 'やま / Yama',
      'onyomi': 'サン / San',
      'title': 'Kanji Lesson 1',
      'options': ['国', '年', '本', '中'],
    },
    {
      'kanji': '水',
      'meaning': 'Water',
      'kunyomi': 'みず / Mizu',
      'onyomi': 'スイ / Sui',
      'title': 'Kanji Lesson 2',
      'options': ['火', '土', '木', '金'],
    },
    {
      'kanji': '人',
      'meaning': 'Person',
      'kunyomi': 'ひと / Hito',
      'onyomi': 'ジン / Jin',
      'title': 'Kanji Lesson 3',
      'options': ['大', '小', '上', '下'],
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadCurrentLesson();
  }

  void playVideo() {
    isVideoPlaying.value = !isVideoPlaying.value;
    if (isVideoPlaying.value) {
      Get.snackbar(
        'Video Playing',
        'Playing ${lessonTitle.value}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.play_circle_filled, color: Colors.white),
      );
    } else {
      Get.snackbar(
        'Video Paused',
        'Video paused',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 1),
        icon: Icon(Icons.pause_circle_filled, color: Colors.white),
      );
    }
  }

  void selectKanjiOption(String kanji) {
    selectedKanji.value = kanji;

    // Check if it's the correct kanji
    bool isCorrect = kanji == currentKanji.value;

    Get.snackbar(
      isCorrect ? 'Correct! 正解!' : 'Try Again! もう一度!',
      isCorrect
          ? 'Great job! You selected the right kanji: $kanji'
          : 'You selected: $kanji. The correct answer is: ${currentKanji.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isCorrect
          ? Colors.green.withOpacity(0.8)
          : Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: Duration(seconds: isCorrect ? 2 : 3),
      icon: Icon(
        isCorrect ? Icons.check_circle : Icons.cancel,
        color: Colors.white,
      ),
    );

    // Auto advance to next lesson if correct
    if (isCorrect) {
      Future.delayed(Duration(seconds: 2), () {
        nextLesson();
      });
    }
  }

  void playAudio(String type) {
    String pronunciation = type == 'kunyomi' ? kunyomi.value : onyomi.value;

    Get.snackbar(
      'Audio Playing',
      'Playing $type: $pronunciation',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.volume_up, color: Colors.white),
    );

    // Simulate audio playback delay
    Future.delayed(Duration(milliseconds: 500), () {
      // Add actual audio playback logic here
      print('Playing audio for $type: $pronunciation');
    });
  }

  void loadCurrentLesson() {
    if (currentLessonIndex.value < lessons.length) {
      isLoading.value = true;

      final lesson = lessons[currentLessonIndex.value];

      // Simulate loading delay
      Future.delayed(Duration(milliseconds: 500), () {
        currentKanji.value = lesson['kanji'];
        kanjiMeaning.value = lesson['meaning'];
        kunyomi.value = lesson['kunyomi'];
        onyomi.value = lesson['onyomi'];
        lessonTitle.value = lesson['title'];
        kanjiOptions.value = List<String>.from(lesson['options']);

        selectedKanji.value = '';
        isVideoPlaying.value = false;
        isLoading.value = false;
      });
    }
  }

  void nextLesson() {
    if (currentLessonIndex.value < lessons.length - 1) {
      currentLessonIndex.value++;
      loadCurrentLesson();

      Get.snackbar(
        'Next Lesson',
        'Loading ${lessons[currentLessonIndex.value]['title']}...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.purple.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 1),
        icon: Icon(Icons.arrow_forward, color: Colors.white),
      );
    } else {
      Get.snackbar(
        'Course Complete! 完了!',
        'Congratulations! You\'ve completed all lessons!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.9),
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.celebration, color: Colors.white),
      );
    }
  }

  void previousLesson() {
    if (currentLessonIndex.value > 0) {
      currentLessonIndex.value--;
      loadCurrentLesson();

      Get.snackbar(
        'Previous Lesson',
        'Loading ${lessons[currentLessonIndex.value]['title']}...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 1),
        icon: Icon(Icons.arrow_back, color: Colors.white),
      );
    }
  }

  void resetCurrentLesson() {
    selectedKanji.value = '';
    isVideoPlaying.value = false;

    Get.snackbar(
      'Lesson Reset',
      'Try the lesson again!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      duration: Duration(seconds: 1),
      icon: Icon(Icons.refresh, color: Colors.white),
    );
  }

  // Getters for computed values
  bool get isFirstLesson => currentLessonIndex.value == 0;
  bool get isLastLesson => currentLessonIndex.value == lessons.length - 1;
  double get progress => (currentLessonIndex.value + 1) / lessons.length;
  String get progressText =>
      '${currentLessonIndex.value + 1} / ${lessons.length}';
}
