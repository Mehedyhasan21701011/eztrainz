import 'dart:convert';
import 'package:eztrainz/app/modules/vocabolarygrammer/controllers/vocabolarygrammer_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WordpageController extends GetxController {
  var allWords = <Map<String, dynamic>>[].obs;
  var filteredWords = <Map<String, dynamic>>[].obs;
  var querydata = ''.obs;
  final RxString selectedCategory = "".obs;
  final VocabolaryController vgController = Get.find<VocabolaryController>();

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = vgController.SelectedCategory.value;
    loadWords();
  }

  Future<void> loadWords() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/words.json',
      );
      final data = json.decode(jsonString);

      // Map the category to the correct JSON key
      String jsonKey = _mapCategoryToJsonKey(selectedCategory.value);

      if (data.containsKey(jsonKey)) {
        final List<dynamic> rawList = data[jsonKey];
        allWords.assignAll(rawList.cast<Map<String, dynamic>>());
        filteredWords.assignAll(allWords);
      } else {
        allWords.clear();
        filteredWords.clear();
      }
    } catch (e) {
      allWords.clear();
      filteredWords.clear();
    }
  }

  String _mapCategoryToJsonKey(String category) {
    // Map the display category names to JSON keys
    switch (category.toLowerCase().trim()) {
      case 'nouns':
      case 'noun':
        return 'nouns';
      case 'pronouns':
      case 'pronoun':
        return 'pronouns';
      case 'verbs':
      case 'verb':
        return 'verbs';
      case 'adjectives':
      case 'adjective':
        return 'adjectives';
      case 'adverbs':
      case 'adverb':
        return 'adverbs';
      default:
        return category.toLowerCase().trim();
    }
  }

  void filterWords(String query) {
    querydata.value = query;
    if (query.isEmpty) {
      filteredWords.assignAll(allWords);
    } else {
      filteredWords.assignAll(
        allWords.where((word) {
          final meaning = (word['meaning'] ?? '').toString().toLowerCase();
          final kanji = (word['kanji'] ?? '').toString().toLowerCase();
          final hiragana = (word['hiragana'] ?? '').toString().toLowerCase();
          final romaji = (word['romaji'] ?? '').toString().toLowerCase();

          final queryLower = query.toLowerCase();
          return meaning.contains(queryLower) ||
              kanji.contains(queryLower) ||
              hiragana.contains(queryLower) ||
              romaji.contains(queryLower);
        }).toList(),
      );
    }
  }

  void addWord(Map<String, dynamic> word) {
    allWords.add(word);
    filterWords(querydata.value);
    update(); // Notify listeners
  }

  void removeWord(int index) {
    if (index >= 0 && index < filteredWords.length) {
      final wordToRemove = filteredWords[index];
      allWords.remove(wordToRemove);
      filterWords(querydata.value);
      update(); // Notify listeners
    }
  }

  void clearSearch() {
    querydata.value = '';
    filteredWords.assignAll(allWords);
  }
}
