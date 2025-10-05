import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListContentController extends GetxController {
  // === Constants ===
  static const Duration _watchedThreshold = Duration(seconds: 1);
  static const int _audioSnackbarDuration = 2;

  /// ✅ Kanji options for the current lesson
  final RxList<String> kanjiOptions = <String>['日', '月', '人', '山', '水'].obs;
  final RxString selectedKanji = '日'.obs;

  /// ✅ Reactive states
  final RxString currentKanji = '日'.obs;
  final RxString kanjiMeaning = 'Sun, Day'.obs;
  final RxString kunyomi = 'ひ / hi'.obs;
  final RxString onyomi = 'ニチ / nichi'.obs;
  final RxString selectedexample = 'あの山は高いです'.obs;

  final RxBool isVideoPlaying = false.obs;
  final RxString lessonTitle = 'Kanji Lesson 1'.obs;
  final RxString hoveredKanji = ''.obs;

  final RxInt currentLessonIndex = 0.obs;
  final RxBool isLoading = false.obs;

  /// ✅ JLPT N5 Level data
  static const List<Map<String, dynamic>> _lessonsData = [
    {
      'kanji': '日',
      'meaning': 'Sun, Day',
      'kunyomi': 'ひ / hi',
      'onyomi': 'ニチ / nichi',
      'title': 'Kanji Lesson 1',
      'options': ['日', '月', '火'],
      'example': 'あの山は高いです',
    },
    {
      'kanji': '月',
      'meaning': 'Moon, Month',
      'kunyomi': 'つき / tsuki',
      'onyomi': 'ゲツ / getsu',
      'title': 'Kanji Lesson 1',
      'options': ['月', '日', '木'],
      'example': '山は高ですあのい',
    },
    {
      'kanji': '人',
      'meaning': 'Person',
      'kunyomi': 'ひと / hito',
      'onyomi': 'ジン / jin',
      'title': 'Kanji Lesson 1',
      'options': ['人', '大', '子'],
      'example': 'での山あ高いはす',
    },
    {
      'kanji': '山',
      'meaning': 'Mountain',
      'kunyomi': 'やま / yama',
      'onyomi': 'サン / san',
      'title': 'Kanji Lesson 1',
      'options': ['山', '川', '田'],
      'example': 'の山はあの山はす',
    },
    {
      'kanji': '水',
      'meaning': 'Water',
      'kunyomi': 'みず / mizu',
      'onyomi': 'スイ / sui',
      'title': 'Kanji Lesson 1',
      'options': ['水', '火', '木'],
      'example': 'の山いです山山',
    },
  ];

  List<Map<String, dynamic>> get lessons => _lessonsData;

  // === Quiz properties ===
  final String question = "What are the 4 Kanjis we learned today?";
  final String answer = "国";
  final List<String> options = ["国", "年", "中"];
  final RxInt selectedOption = (-1).obs;
  final RxBool isAnswered = false.obs;
  final RxBool cardVisibility = true.obs;
  final RxBool displayVisibility = true.obs;
  final RxBool isAnsSelected = false.obs;

  // === Computed getters ===
  bool get isFirstLesson => currentLessonIndex.value == 0;
  bool get isLastLesson => currentLessonIndex.value == lessons.length - 1;
  double get progress => (currentLessonIndex.value + 1) / lessons.length;
  String get progressText =>
      '${currentLessonIndex.value + 1} / ${lessons.length}';

  // === Video related ===
  final RxString url = ''.obs;
  final RxBool watched = false.obs;

  late YoutubePlayerController ytcontroller;
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final RxDouble progressPercent = 0.0.obs;

  bool _pausedOnce = false;

  @override
  void onInit() {
    super.onInit();

    // Initialize video
    final defaultUrl =
        "https://www.youtube.com/watch?v=w0nP5wFEYhU&list=PLoTQRR5Zh5qLiZiGwpmvJWZnp5hddBLQV";
    final videoId = YoutubePlayer.convertUrlToId(defaultUrl) ?? "";

    ytcontroller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        disableDragSeek: false,
      ),
    );

    ytcontroller.addListener(_onVideoProgressChanged);

    // Set default URL
    url.value = defaultUrl;

    // Reactively update when URL changes
    ever(url, (String newUrl) {
      final newVideoId = YoutubePlayer.convertUrlToId(newUrl) ?? "";
      if (newVideoId.isNotEmpty) {
        ytcontroller.load(newVideoId);
        ytcontroller.pause(); // prevent autoplay
        _pausedOnce = false;
        displayVisibility.value = true;
        cardVisibility.value = false;
      }
    });
  }

  @override
  void onClose() {
    _disposeResources();
    super.onClose();
  }

  void _onVideoProgressChanged() {
    if (!ytcontroller.value.isReady) return;

    final currentPos = ytcontroller.value.position;
    final totalDuration = ytcontroller.metadata.duration;

    _updateVideoProgress(currentPos, totalDuration);
    _checkWatchedStatus(currentPos, totalDuration);

    // Pause after 10 seconds
    if (!_pausedOnce && currentPos.inSeconds >= 10) {
      ytcontroller.pause();
      displayVisibility.value = false;
      cardVisibility.value = true;
      _pausedOnce = true;
    }
  }

  void _updateVideoProgress(Duration currentPos, Duration totalDuration) {
    currentPosition.value = currentPos;
    progressPercent.value = totalDuration.inSeconds > 0
        ? currentPos.inMilliseconds / totalDuration.inMilliseconds
        : 0.0;
  }

  void _checkWatchedStatus(Duration currentPos, Duration totalDuration) {
    if (!watched.value &&
        totalDuration.inSeconds > 0 &&
        currentPos >= totalDuration - _watchedThreshold) {
      watched.value = true;
      debugPrint("✅ Video watched completely!");
    }
  }

  void _disposeResources() {
    ytcontroller.removeListener(_onVideoProgressChanged);
    ytcontroller.dispose();
  }

  // ================== QUIZ & LESSON ==================

  void selectKanji(String kanji) {
    selectedKanji.value = kanji;
    final lesson = _lessonsData.firstWhere((l) => l['kanji'] == kanji);
    currentKanji.value = lesson['kanji'];
    kanjiMeaning.value = lesson['meaning'];
    kunyomi.value = lesson['kunyomi'];
    onyomi.value = lesson['onyomi'];
    lessonTitle.value = lesson['title'];
    selectedexample.value = lesson['example'];
  }

  void resetQuiz() {
    selectedOption.value = -1;
    isAnswered.value = false;
    cardVisibility.value = true;
    isAnsSelected.value = false;
  }

  Map<String, dynamic>? getCurrentLessonData() {
    if (currentLessonIndex.value >= 0 &&
        currentLessonIndex.value < lessons.length) {
      return lessons[currentLessonIndex.value];
    }
    return null;
  }

  void nextLesson() {
    if (isLastLesson) return;
    currentLessonIndex.value++;
    _loadLessonData();
    resetQuiz();
  }

  void previousLesson() {
    if (isFirstLesson) return;
    currentLessonIndex.value--;
    _loadLessonData();
    resetQuiz();
  }

  void _loadLessonData() {
    final lessonData = getCurrentLessonData();
    if (lessonData != null) {
      currentKanji.value = lessonData['kanji'] ?? '';
      kanjiMeaning.value = lessonData['meaning'] ?? '';
      kunyomi.value = lessonData['kunyomi'] ?? '';
      onyomi.value = lessonData['onyomi'] ?? '';
      lessonTitle.value = lessonData['title'] ?? '';
      final optionsList = lessonData['options'];
      if (optionsList is List) {
        kanjiOptions.assignAll(optionsList.whereType<String>().toList());
      }
    }
  }

  // ================== AUDIO ==================
  void playAudio(String type) {
    if (type != 'kunyomi' && type != 'onyomi') return;

    final pronunciation = type == 'kunyomi' ? kunyomi.value : onyomi.value;

    Get.snackbar(
      'Audio Playing',
      'Playing $type: $pronunciation',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: _audioSnackbarDuration),
      icon: const Icon(Icons.volume_up, color: Colors.white),
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      debugPrint('Playing audio: $pronunciation');
    });
  }
}
