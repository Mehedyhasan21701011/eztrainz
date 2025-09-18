import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListContentController extends GetxController {
  // Constants
  static const Duration _watchedThreshold = Duration(seconds: 1);
  static const int _audioSnackbarDuration = 2;

  /// Kanji options for the current lesson
  final RxList<String> kanjiOptions = <String>['国', '年', '水', '山', '大'].obs;
  final RxString selectedKanji = '国'.obs;

  void selectKanji(String kanji) {
    selectedKanji.value = kanji;
    final lesson = _lessonsData.firstWhere((l) => l['kanji'] == kanji);
    currentKanji.value = lesson['kanji'];
    kanjiMeaning.value = lesson['meaning'];
    kunyomi.value = lesson['kunyomi'];
    onyomi.value = lesson['onyomi'];
    lessonTitle.value = lesson['title'];
  }

  /// Reactive states for Kanji lesson
  final RxString currentKanji = '山'.obs;
  final RxString kanjiMeaning = 'Mountain'.obs;
  final RxString kunyomi = 'やま / Yama'.obs;
  final RxString onyomi = 'サン / San'.obs;

  final RxBool isVideoPlaying = false.obs;
  final RxString lessonTitle = 'Kanji Lesson 1'.obs;
  final RxString hoveredKanji = ''.obs;

  final RxInt currentLessonIndex = 0.obs;
  final RxBool isLoading = false.obs;

  /// Sample lesson data - made immutable
  static const List<Map<String, dynamic>> _lessonsData = [
    {
      'kanji': '国',
      'meaning': 'Book',
      'kunyomi': 'やま / Yama',
      'onyomi': 'サン / San',
      'title': 'Kanji Lesson 1',
      'options': ['国', '年', '本'],
    },
    {
      'kanji': '年',
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
      'kanji': '山',
      'meaning': 'Person',
      'kunyomi': 'ひと / Hito',
      'onyomi': 'ジン / Jin',
      'title': 'Kanji Lesson 3',
      'options': ['大', '小', '上'],
    },
    {
      'kanji': '大',
      'meaning': 'Person',
      'kunyomi': 'ひと / Hito',
      'onyomi': 'ジン / Jin',
      'title': 'Kanji Lesson 3',
      'options': ['大', '小', '上'],
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

  // Video properties - made nullable initially
  String url = '';
  String title = '';
  final RxBool watched = false.obs;

  late YoutubePlayerController ytController;

  // Reactive video position and progress
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final RxDouble progressPercent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    // Check if arguments exist before initializing
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

  /// Initialize video controller and setup listeners
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

  /// Extract video data from arguments
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

  /// Setup YouTube controller with error handling
  void _setupYouTubeController() {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId == null || videoId.isEmpty) {
      throw Exception('Invalid YouTube URL: $url');
    }

    ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false, loop: true),
    );
  }

  /// Setup video progress listener
  void _setupVideoListener() {
    ytController.addListener(_onVideoProgressChanged);
  }

  /// Handle video progress changes
  /// Handle video progress changes
  void _onVideoProgressChanged() {
    final currentPos = ytController.value.position;
    final totalDuration = ytController.metadata.duration;

    _updateVideoProgress(currentPos, totalDuration);
    _checkWatchedStatus(currentPos, totalDuration);

    // ✅ Stop video after 10 seconds
    if (currentPos.inSeconds >= 5) {
      ytController.pause();
      displayVisibility.value = false;
    }
  }

  /// Update video progress values
  void _updateVideoProgress(Duration currentPos, Duration totalDuration) {
    currentPosition.value = currentPos;

    if (totalDuration.inSeconds > 0) {
      progressPercent.value =
          currentPos.inMilliseconds / totalDuration.inMilliseconds;
    }
  }

  /// Check if video should be marked as watched
  void _checkWatchedStatus(Duration currentPos, Duration totalDuration) {
    if (!watched.value &&
        totalDuration.inSeconds > 0 &&
        currentPos >= totalDuration - _watchedThreshold) {
      _markVideoAsWatched();
    }
  }

  /// Mark video as completely watched
  void _markVideoAsWatched() {
    watched.value = true;
    debugPrint("✅ Video watched completely!");
  }

  /// Kanji selection with validation
  void selectKanjiOption(String kanji) {
    if (kanji.isNotEmpty && kanjiOptions.contains(kanji)) {
      selectedKanji.value = kanji;
    } else {
      debugPrint('Warning: Invalid kanji selection: $kanji');
    }
  }

  /// Play audio with improved UX
  void playAudio(String type) {
    if (!_isValidAudioType(type)) {
      debugPrint('Warning: Invalid audio type: $type');
      return;
    }

    final pronunciation = _getPronunciation(type);
    _showAudioSnackbar(type, pronunciation);
    _simulateAudioPlayback(pronunciation);
  }

  /// Validate audio type
  bool _isValidAudioType(String type) {
    return type == 'kunyomi' || type == 'onyomi';
  }

  /// Get pronunciation based on type
  String _getPronunciation(String type) {
    return type == 'kunyomi' ? kunyomi.value : onyomi.value;
  }

  /// Show audio playing snackbar
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

  /// Simulate audio playback
  Future<void> _simulateAudioPlayback(String pronunciation) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    debugPrint('Playing audio: $pronunciation');
  }

  /// Handle errors with user feedback
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

  /// Clean up resources
  void _disposeResources() {
    try {
      ytController.removeListener(_onVideoProgressChanged);
      ytController.dispose();
    } catch (e) {
      debugPrint('Error disposing resources: $e');
    }
  }

  /// Reset quiz state
  void resetQuiz() {
    selectedOption.value = -1;
    isAnswered.value = false;
    cardVisibility.value = true;
    isAnsSelected.value = false;
  }

  /// Get current lesson data
  Map<String, dynamic>? getCurrentLessonData() {
    if (currentLessonIndex.value >= 0 &&
        currentLessonIndex.value < lessons.length) {
      return lessons[currentLessonIndex.value];
    }
    return null;
  }

  /// Navigate to next lesson
  void nextLesson() {
    if (!isLastLesson) {
      currentLessonIndex.value++;
      _loadLessonData();
      resetQuiz();
    }
  }

  /// Navigate to previous lesson
  void previousLesson() {
    if (!isFirstLesson) {
      currentLessonIndex.value--;
      _loadLessonData();
      resetQuiz();
    }
  }

  /// Load lesson data for current index
  void _loadLessonData() {
    final lessonData = getCurrentLessonData();
    if (lessonData != null) {
      final kanjiValue = lessonData['kanji'];
      final meaningValue = lessonData['meaning'];
      final kunyomiValue = lessonData['kunyomi'];
      final onyomiValue = lessonData['onyomi'];
      final titleValue = lessonData['title'];
      final optionsList = lessonData['options'];

      currentKanji.value = kanjiValue is String ? kanjiValue : '';
      kanjiMeaning.value = meaningValue is String ? meaningValue : '';
      kunyomi.value = kunyomiValue is String ? kunyomiValue : '';
      onyomi.value = onyomiValue is String ? onyomiValue : '';
      lessonTitle.value = titleValue is String ? titleValue : '';

      if (optionsList is List) {
        kanjiOptions.assignAll(optionsList.whereType<String>().toList());
      }
    }
  }
}
