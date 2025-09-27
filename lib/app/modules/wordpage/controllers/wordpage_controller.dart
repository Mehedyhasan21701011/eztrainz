import 'dart:convert';
import 'package:eztrainz/app/modules/vocabolarygrammer/controllers/vocabolarygrammer_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WordpageController extends GetxController {
  var allWords = <Map<String, dynamic>>[].obs;
  var filteredWords = <Map<String, dynamic>>[].obs;

  var searchQuery = ''.obs;
  final RxString selectedCategory = "".obs;

  final VocabolaryController vgController = Get.find<VocabolaryController>();

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = vgController.SelectedCategory.value;
    loadWords();
  }

  Future<void> loadWords() async {
    final String jsonString = await rootBundle.loadString('assets/words.json');
    final data = json.decode(jsonString);

    final key = selectedCategory.value.trim().toLowerCase();

    if (data.containsKey(key)) {
      final List<dynamic> rawList = data[key];

      allWords.assignAll(rawList.cast<Map<String, dynamic>>());
      filteredWords.assignAll(allWords);
    } else {
      allWords.clear();
      filteredWords.clear();
    }
  }

  void filterWords(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredWords.assignAll(allWords);
    } else {
      filteredWords.assignAll(
        allWords.where((word) {
          final meaning = (word['meaning'] ?? '').toString().toLowerCase();
          return meaning.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }

  void addWord(Map<String, dynamic> word) {
    allWords.add(word);
    filterWords(searchQuery.value);
  }
}
