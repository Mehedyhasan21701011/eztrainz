import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListContentController extends GetxController {
  /// Reactive states for Kanji lesson
  final RxString currentKanji = '山'.obs;
  final RxString kanjiMeaning = 'Mountain'.obs;
  final RxString kunyomi = 'やま / Yama'.obs;
  final RxString onyomi = 'サン / San'.obs;

  final RxBool isVideoPlaying = false.obs;
  final RxString lessonTitle = 'Kanji Lesson 1'.obs;
  final RxString selectedKanji = ''.obs;
  final RxString hoveredKanji = ''.obs;

  final RxInt currentLessonIndex = 0.obs;
  final RxBool isLoading = false.obs;

  /// Kanji options for the current lesson
  final RxList<String> kanjiOptions = <String>['国', '年', '本', '中'].obs;

  /// Sample lesson data
  final List<Map<String, dynamic>> lessons = [
    {
      'kanji': '山',
      'meaning': 'Mountain',
      'kunyomi': 'やま / Yama',
      'onyomi': 'サン / San',
      'title': 'Kanji Lesson 1',
      'options': ['国', '年', '本'],
    },
    {
      'kanji': '水',
      'meaning': 'Water',
      'kunyomi': 'みず / Mizu',
      'onyomi': 'スイ / Sui',
      'title': 'Kanji Lesson 2',
      'options': ['火', '土', '木'],
    },
    {
      'kanji': '人',
      'meaning': 'Person',
      'kunyomi': 'ひと / Hito',
      'onyomi': 'ジン / Jin',
      'title': 'Kanji Lesson 3',
      'options': ['大', '小', '上'],
    },
  ];

  // Card quiz example
  final String question = "What are the 4 Kanjis we learned today?";
  final String answer = "国";
  final List<String> options = ["国", "年", "中"];
  RxInt selectedOption = (-1).obs;
  RxBool isAnswered = false.obs;

  /// Computed values
  bool get isFirstLesson => currentLessonIndex.value == 0;
  bool get isLastLesson => currentLessonIndex.value == lessons.length - 1;
  double get progress => (currentLessonIndex.value + 1) / lessons.length;
  String get progressText =>
      '${currentLessonIndex.value + 1} / ${lessons.length}';

  // Video properties
  late String url;
  late String title;
  RxBool watched = false.obs;

  late YoutubePlayerController ytController;

  // Reactive video position and progress
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxDouble progressPercent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    // Receive arguments from previous screen
    //video
    final contentItem = Get.arguments as Map<String, dynamic>;
    url = contentItem['url'];
    title = contentItem['title'];
    watched.value = contentItem['watched'] ?? false;
    final videoId = YoutubePlayer.convertUrlToId(url) ?? "";
    ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true, // important for watched detection
      ),
    );

    // Listener to track position and watched state
    ytController.addListener(() {
      final currentPos = ytController.value.position;
      final totalDuration = ytController.metadata.duration;

      currentPosition.value = currentPos;

      if (totalDuration.inSeconds > 0) {
        progressPercent.value =
            currentPos.inMilliseconds / totalDuration.inMilliseconds;
      }

      // Mark video as watched if near the end
      if (!watched.value &&
          totalDuration.inSeconds > 0 &&
          currentPos >= totalDuration - const Duration(seconds: 1)) {
        watched.value = true;
        print("✅ Video watched completely!");
      }
    });
  }

  @override
  void onClose() {
    ytController.dispose();
    super.onClose();
  }

  /// Kanji selection
  void selectKanjiOption(String kanji) {
    selectedKanji.value = kanji;
  }

  /// Play Kunyomi or Onyomi audio (mocked)
  void playAudio(String type) {
    final pronunciation = type == 'kunyomi' ? kunyomi.value : onyomi.value;

    Get.snackbar(
      'Audio Playing',
      'Playing $type: $pronunciation',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.volume_up, color: Colors.white),
    );

    // Simulate audio playback
    Future.delayed(const Duration(milliseconds: 1000), () {
      debugPrint('Playing audio: $pronunciation');
    });
  }
}
