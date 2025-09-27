import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListContentController extends GetxController {
  // Constants
  static const Duration _watchedThreshold = Duration(seconds: 1);
  static const int _audioSnackbarDuration = 2;

  /// Kanji options for the current lesson
  final RxList<String> kanjiOptions = <String>['日', '月', '人', '山', '水'].obs;
  final RxString selectedKanji = '日'.obs;

  void selectKanji(String kanji) {
    selectedKanji.value = kanji;
    final lesson = _lessonsData.firstWhere((l) => l['kanji'] == kanji);
    currentKanji.value = lesson['kanji'];
    kanjiMeaning.value = lesson['meaning'];
    kunyomi.value = lesson['kunyomi'];
    onyomi.value = lesson['onyomi'];
    lessonTitle.value = lesson['title'];
  }

  /// ✅ Reactive states for Kanji lesson
  final RxString currentKanji = '日'.obs;
  final RxString kanjiMeaning = 'Sun, Day'.obs;
  final RxString kunyomi = 'ひ / hi'.obs;
  final RxString onyomi = 'ニチ / nichi'.obs;

  final RxBool isVideoPlaying = false.obs;
  final RxString lessonTitle = 'Kanji Lesson 1'.obs;
  final RxString hoveredKanji = ''.obs;

  final RxInt currentLessonIndex = 0.obs;
  final RxBool isLoading = false.obs;

  /// ✅ Meaningful Kanji lesson data (JLPT N5 Level)
  static const List<Map<String, dynamic>> _lessonsData = [
    {
      'kanji': '日',
      'meaning': 'Sun, Day',
      'kunyomi': 'ひ / hi',
      'onyomi': 'ニチ / nichi',
      'title': 'Kanji Lesson 1',
      'options': ['日', '月', '火'],
    },
    {
      'kanji': '月',
      'meaning': 'Moon, Month',
      'kunyomi': 'つき / tsuki',
      'onyomi': 'ゲツ / getsu',
      'title': 'Kanji Lesson 1',
      'options': ['月', '日', '木'],
    },
    {
      'kanji': '人',
      'meaning': 'Person',
      'kunyomi': 'ひと / hito',
      'onyomi': 'ジン / jin',
      'title': 'Kanji Lesson 1',
      'options': ['人', '大', '子'],
    },
    {
      'kanji': '山',
      'meaning': 'Mountain',
      'kunyomi': 'やま / yama',
      'onyomi': 'サン / san',
      'title': 'Kanji Lesson 1',
      'options': ['山', '川', '田'],
    },
    {
      'kanji': '水',
      'meaning': 'Water',
      'kunyomi': 'みず / mizu',
      'onyomi': 'スイ / sui',
      'title': 'Kanji Lesson 1',
      'options': ['水', '火', '木'],
    },
  ];

  List<Map<String, dynamic>> get lessons => _lessonsData;

  // Card quiz properties
  final String question = "What are the 4 Kanjis we learned today?";
  final String answer = "国";
  final List<String> options = ["国", "年", "中"];
  final RxInt selectedOption = (-1).obs;
  final RxBool isAnswered = false.obs;
  final RxBool cardVisibility = true.obs;
  final RxBool displayVisibility = true.obs;
  final RxBool isAnsSelected = false.obs;

  /// Computed getters - cached for performance
  bool get isFirstLesson => currentLessonIndex.value == 0;
  bool get isLastLesson => currentLessonIndex.value == lessons.length - 1;
  double get progress => (currentLessonIndex.value + 1) / lessons.length;
  String get progressText =>
      '${currentLessonIndex.value + 1} / ${lessons.length}';

  // Video properties
  String url = '';
  String title = '';
  final RxBool watched = false.obs;

  late YoutubePlayerController ytController;
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final RxDouble progressPercent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments == null) {
      _handleError('No content arguments provided');
      return;
    }
    _initializeVideo();
  }

  @override
  void onClose() {
    _disposeResources();
    super.onClose();
  }

  void _initializeVideo() {
    try {
      final arguments = Get.arguments;
      if (arguments == null) {
        _handleError('No arguments provided');
        return;
      }
      final contentItem = arguments is Map<String, dynamic>
          ? arguments
          : <String, dynamic>{};

      _extractVideoData(contentItem);
      _setupYouTubeController();
      _setupVideoListener();
    } catch (e) {
      _handleError('Failed to initialize video: $e');
    }
  }

  void _extractVideoData(Map<String, dynamic> contentItem) {
    final urlValue = contentItem['url'];
    final titleValue = contentItem['title'];
    final watchedValue = contentItem['watched'];

    url = urlValue is String ? urlValue : '';
    title = titleValue is String ? titleValue : 'Unknown Title';
    watched.value = watchedValue is bool ? watchedValue : false;

    if (url.isEmpty) {
      throw Exception('Video URL is empty');
    }
  }

  void _setupYouTubeController() {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId == null || videoId.isEmpty) {
      throw Exception('Invalid YouTube URL: $url');
    }

    ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
      ),
    );
  }

  bool _pausedOnce = false;

  void _setupVideoListener() {
    ytController.addListener(_onVideoProgressChanged);
  }

  void _onVideoProgressChanged() {
    final currentPos = ytController.value.position;
    final totalDuration = ytController.metadata.duration;

    _updateVideoProgress(currentPos, totalDuration);
    _checkWatchedStatus(currentPos, totalDuration);

    if (!_pausedOnce && currentPos.inSeconds >= 5) {
      ytController.pause();
      displayVisibility.value = false;
      cardVisibility.value = true;
      _pausedOnce = true;
    }
  }

  void _updateVideoProgress(Duration currentPos, Duration totalDuration) {
    currentPosition.value = currentPos;
    final arguments = Get.arguments;
    final contentItem = arguments is Map<String, dynamic>
        ? arguments
        : <String, dynamic>{};
    contentItem['progress'] = totalDuration.inSeconds > 0
        ? currentPos.inMilliseconds / totalDuration.inMilliseconds
        : 0.0;
  }

  void _checkWatchedStatus(Duration currentPos, Duration totalDuration) {
    if (!watched.value &&
        totalDuration.inSeconds > 0 &&
        currentPos >= totalDuration - _watchedThreshold) {
      _markVideoAsWatched();
    }
  }

  void _markVideoAsWatched() {
    watched.value = true;
    debugPrint("✅ Video watched completely!");
  }

  void selectKanjiOption(String kanji) {
    if (kanji.isNotEmpty && kanjiOptions.contains(kanji)) {
      selectedKanji.value = kanji;
    } else {
      debugPrint('Warning: Invalid kanji selection: $kanji');
    }
  }

  void playAudio(String type) {
    if (!_isValidAudioType(type)) {
      debugPrint('Warning: Invalid audio type: $type');
      return;
    }

    final pronunciation = _getPronunciation(type);
    _showAudioSnackbar(type, pronunciation);
    _simulateAudioPlayback(pronunciation);
  }

  bool _isValidAudioType(String type) {
    return type == 'kunyomi' || type == 'onyomi';
  }

  String _getPronunciation(String type) {
    return type == 'kunyomi' ? kunyomi.value : onyomi.value;
  }

  void _showAudioSnackbar(String type, String pronunciation) {
    Get.snackbar(
      'Audio Playing',
      'Playing $type: $pronunciation',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: _audioSnackbarDuration),
      icon: const Icon(Icons.volume_up, color: Colors.white),
    );
  }

  Future<void> _simulateAudioPlayback(String pronunciation) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    debugPrint('Playing audio: $pronunciation');
  }

  void _handleError(String message) {
    debugPrint('Error: $message');
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  void _disposeResources() {
    try {
      ytController.removeListener(_onVideoProgressChanged);
      ytController.dispose();
    } catch (e) {
      debugPrint('Error disposing resources: $e');
    }
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
    if (!isLastLesson) {
      currentLessonIndex.value++;
      _loadLessonData();
      resetQuiz();
    }
  }

  void previousLesson() {
    if (!isFirstLesson) {
      currentLessonIndex.value--;
      _loadLessonData();
      resetQuiz();
    }
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
}
