import 'dart:convert';
import 'package:eztrainz/app/modules/vocabolarygrammer/controllers/vocabolarygrammer_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WordpageController extends GetxController {
  var allWords = <String>[].obs;
  var filteredWords = <String>[].obs;
  var searchQuery = ''.obs;
  final RxString selectedCategory = "".obs;

  final VocabolaryController vgController = Get.find<VocabolaryController>();

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = vgController.SelectedCategory.value;
    loadWords(selectedCategory);
  }

  Future<void> loadWords(selectedCategory) async {
    final String jsonString = await rootBundle.loadString('assets/words.json');
    final data = json.decode(jsonString);

    allWords.assignAll(List<String>.from(data[selectedCategory]));
    filteredWords.assignAll(allWords);
  }

  void filterWords(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredWords.assignAll(allWords);
    } else {
      filteredWords.assignAll(
        allWords.where(
          (word) => word.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  void addWord(String word) {
    allWords.add(word);
    filterWords(searchQuery.value);
  }
}
