// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VocabolaryController extends GetxController {
  // Observable variables
  final RxString selectedTab = "Grammar".obs;
  final RxInt currentWordIndex = 0.obs;
  final RxString searchQuery = "".obs;
  final RxBool isPlaying = false.obs;
  final RxString SelectedCategory = "".obs;

  // Data
  final RxList<Map<String, dynamic>> todaysWords = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> exploreMore = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredExplore =
      <Map<String, dynamic>>[].obs;

  // Youtube Controller
  YoutubePlayerController? ytController;

  @override
  void onInit() {
    super.onInit();
    loadData();

    // ✅ Initialize YouTube controller
    _initializeYoutubeController();

    // ✅ React to tab changes and update video dynamically
    ever(selectedTab, (_) {
      _initializeYoutubeController();
    });

    // ✅ Listen to search changes
    debounce(
      searchQuery,
      (_) => filterExploreMore(),
      time: const Duration(milliseconds: 300),
    );
  }

  void _initializeYoutubeController() {
    const vocabUrl = "https://www.youtube.com/watch?v=1QBBa0pds8k";
    const grammarUrl =
        "https://www.youtube.com/watch?v=SPXQ8Bx-O_g&list=PLKOA3pgec-PYUd-aX8ArRqgfX8jvtJy6- ";

    final selectedUrl = selectedTab.value == "Grammar" ? grammarUrl : vocabUrl;
    final videoId = YoutubePlayer.convertUrlToId(selectedUrl);

    if (videoId == null) return;

    if (ytController == null) {
      // First time initialization
      ytController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    } else {
      // Just load new video without disposing controller
      ytController!.load(videoId);
    }

    update();
  }

  @override
  void onClose() {
    ytController?.dispose(); // ✅ Dispose to prevent memory leaks
    super.onClose();
  }

  void loadData() {
    // Your word data remains unchanged...
    todaysWords.value = [
      {
        "id": 1,
        "kanji": "木",
        "hiragana": "き",
        "romaji": "ki",
        "meaning": "tree",
        "image": "assets/tree.png",
        "audio": "ki.mp3",
        "sentence": {
          "japanese": "この木はきれいです。",
          "romaji": "Kono ki wa kirei desu.",
          "english": "This tree is beautiful.",
        },
      },
      {
        "id": 2,
        "kanji": "水",
        "hiragana": "みず",
        "romaji": "mizu",
        "meaning": "water",
        "image": "assets/water.png",
        "audio": "mizu.mp3",
        "sentence": {
          "japanese": "水を飲みます。",
          "romaji": "Mizu wo nomimasu.",
          "english": "I drink water.",
        },
      },
      {
        "id": 3,
        "kanji": "本",
        "hiragana": "ほん",
        "romaji": "hon",
        "meaning": "book",
        "image": "assets/book.png",
        "audio": "hon.mp3",
        "sentence": {
          "japanese": "本を読みます。",
          "romaji": "Hon wo yomimasu.",
          "english": "I read a book.",
        },
      },
    ];

    exploreMore.value = [
      {
        "category": "Nouns",
        "japanese": "めいし",
        "items": [
          {"kanji": "犬", "hiragana": "いぬ", "romaji": "inu", "meaning": "dog"},
          {"kanji": "猫", "hiragana": "ねこ", "romaji": "neko", "meaning": "cat"},
          {
            "kanji": "車",
            "hiragana": "くるま",
            "romaji": "kuruma",
            "meaning": "car",
          },
          {"kanji": "家", "hiragana": "いえ", "romaji": "ie", "meaning": "house"},
          {
            "kanji": "学校",
            "hiragana": "がっこう",
            "romaji": "gakkou",
            "meaning": "school",
          },
        ],
      },
      {
        "category": "Pronoun",
        "japanese": "だいめいし",
        "items": [
          {
            "kanji": "私",
            "hiragana": "わたし",
            "romaji": "watashi",
            "meaning": "I/me",
          },
          {
            "kanji": "あなた",
            "hiragana": "あなた",
            "romaji": "anata",
            "meaning": "you",
          },
          {
            "kanji": "彼",
            "hiragana": "かれ",
            "romaji": "kare",
            "meaning": "he/him",
          },
          {
            "kanji": "彼女",
            "hiragana": "かのじょ",
            "romaji": "kanojo",
            "meaning": "she/her",
          },
          {
            "kanji": "これ",
            "hiragana": "これ",
            "romaji": "kore",
            "meaning": "this",
          },
        ],
      },
      {
        "category": "Verb",
        "japanese": "どうし",
        "items": [
          {
            "kanji": "食べる",
            "hiragana": "たべる",
            "romaji": "taberu",
            "meaning": "to eat",
          },
          {
            "kanji": "飲む",
            "hiragana": "のむ",
            "romaji": "nomu",
            "meaning": "to drink",
          },
          {
            "kanji": "見る",
            "hiragana": "みる",
            "romaji": "miru",
            "meaning": "to see/watch",
          },
          {
            "kanji": "行く",
            "hiragana": "いく",
            "romaji": "iku",
            "meaning": "to go",
          },
          {
            "kanji": "来る",
            "hiragana": "くる",
            "romaji": "kuru",
            "meaning": "to come",
          },
        ],
      },
    ];

    filteredExplore.value = exploreMore;
  }

  // Tab selection
  void selectTab(String tab) => selectedTab.value = tab;

  // Navigation
  void nextWord() {
    if (currentWordIndex.value < todaysWords.length - 1) {
      currentWordIndex.value++;
    }
  }

  void previousWord() {
    if (currentWordIndex.value > 0) currentWordIndex.value--;
  }

  void goToWord(int index) {
    if (index >= 0 && index < todaysWords.length) {
      currentWordIndex.value = index;
    }
  }

  // Audio
  void playAudio() {
    isPlaying.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(seconds: 2), () => isPlaying.value = false);
  }

  // Search
  void updateSearchQuery(String query) => searchQuery.value = query;

  void filterExploreMore() {
    if (searchQuery.value.isEmpty) {
      filteredExplore.value = exploreMore;
    } else {
      filteredExplore.value = exploreMore
          .map((category) {
            final filteredItems = (category['items'] as List).where((item) {
              return item['romaji'].toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ) ||
                  item['meaning'].toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ) ||
                  item['hiragana'].contains(searchQuery.value) ||
                  item['kanji'].contains(searchQuery.value);
            }).toList();
            return {...category, 'items': filteredItems};
          })
          .where((category) => (category['items'] as List).isNotEmpty)
          .toList();
    }
  }

  // Getters
  Map<String, dynamic> getCurrentWord() =>
      todaysWords.isNotEmpty ? todaysWords[currentWordIndex.value] : {};

  bool get hasNextWord => currentWordIndex.value < todaysWords.length - 1;
  bool get hasPreviousWord => currentWordIndex.value > 0;
}
