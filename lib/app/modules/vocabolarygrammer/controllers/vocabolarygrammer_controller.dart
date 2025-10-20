// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter/services.dart';

class VocabolaryController extends GetxController {
  // Observable variables
  final RxString selectedTab = "Grammar".obs;
  final RxInt currentWordIndex = 0.obs;
  final RxString querydata = "".obs;
  final RxBool isPlaying = false.obs;
  final RxString SelectedCategory = "".obs;

  // Data
  final RxList<Map<String, dynamic>> todaysWords = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> exploreMore = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredExplore =
      <Map<String, dynamic>>[].obs;

  final RxString selectedUrl = "".obs;
  @override
  void onInit() {
    super.onInit();
    loadData();

    _initializeYoutubeUrl();
    ever(selectedTab, (_) {
      _initializeYoutubeUrl();
    });
    debounce(
      querydata,
      (_) => filterExploreMore(),
      time: const Duration(milliseconds: 300),
    );
  }

  void _initializeYoutubeUrl() {
    String vocabUrl = "https://www.youtube.com/watch?v=1QBBa0pds8k";
    String grammarUrl =
        "https://www.youtube.com/watch?v=SPXQ8Bx-O_g&list=PLKOA3pgec-PYUd-aX8ArRqgfX8jvtJy6-";

    selectedUrl.value = selectedTab.value == "Grammar" ? grammarUrl : vocabUrl;
    update();
  }

  void loadData() {
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
      {"category": "Nouns", "japanese": "めいし"},
      {"category": "Pronoun", "japanese": "だいめいし"},
      {"category": "Verb", "japanese": "どうし"},
    ];

    filteredExplore.value = exploreMore;
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

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

  void filterWords(String value) {
    querydata.value = value;
  }

  void filterExploreMore() {
    if (querydata.value.isEmpty) {
      filteredExplore.value = exploreMore;
    } else {
      filteredExplore.value = exploreMore
          .where(
            (item) =>
                item['category'].toString().toLowerCase().contains(
                  querydata.value.toLowerCase(),
                ) ||
                item['japanese'].toString().contains(querydata.value),
          )
          .toList();
    }
  }

  void clearSearch() {
    querydata.value = "";
    filterExploreMore();
  }

  // Getters
  Map<String, dynamic> getCurrentWord() =>
      todaysWords.isNotEmpty ? todaysWords[currentWordIndex.value] : {};

  bool get hasNextWord => currentWordIndex.value < todaysWords.length - 1;
  bool get hasPreviousWord => currentWordIndex.value > 0;
}
