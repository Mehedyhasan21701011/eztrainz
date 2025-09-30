import 'package:get/get.dart';

class Verb {
  final String english;
  final String kanji;
  final String hiragana;
  final String romaji;
  final String explanation;
  final List<Conjugation> conjugations;

  Verb({
    required this.english,
    required this.kanji,
    required this.hiragana,
    required this.romaji,
    required this.explanation,
    required this.conjugations,
  });
}

class Conjugation {
  final String form;
  final String japanese;
  final String meaning;

  Conjugation({
    required this.form,
    required this.japanese,
    required this.meaning,
  });
}

class LearngrammerController extends GetxController {
  var selectedIndex = 0.obs; // 0 = Structure, 1 = Verb

  /// Grammar cards
  final List<Map<String, String>> grammarCards = [
    {
      "title": "Sentence Foundation",
      "description": "Build basic Japanese sentences with polite endings.",
    },
    {
      "title": "Core Particles",
      "description": "Learn the small words that link ideas and show meanings.",
    },
    {
      "title": "Nouns & Pronouns",
      "description": "Key words for people, places, and everyday things.",
    },
    {
      "title": "Adjectives",
      "description": "Learn how “i” and “na” adjectives shapes descriptions.",
    },
    {
      "title": "Describe & Connect",
      "description": "Combine words to express complete ideas.",
    },
  ];

  /// Verb list
  var verbs = <Verb>[
    Verb(
      english: "Wash",
      kanji: "洗う",
      hiragana: "あらう",
      romaji: "arau",
      explanation:
          "Use this verb when talking about washing things like hands, dishes, or clothes.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "洗う", meaning: "to wash"),
        Conjugation(form: "Polite", japanese: "洗います", meaning: "I wash"),
        Conjugation(
          form: "Polite Past",
          japanese: "洗いました",
          meaning: "I washed",
        ),
      ],
    ),
    Verb(
      english: "Eat",
      kanji: "食べる",
      hiragana: "たべる",
      romaji: "taberu",
      explanation: "Use this verb when talking about eating food.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "食べる", meaning: "to eat"),
        Conjugation(form: "Polite", japanese: "食べます", meaning: "I eat"),
        Conjugation(form: "Polite Past", japanese: "食べました", meaning: "I ate"),
      ],
    ),
    Verb(
      english: "Drink",
      kanji: "飲む",
      hiragana: "のむ",
      romaji: "nomu",
      explanation: "Use this verb when talking about drinking liquids.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "飲む", meaning: "to drink"),
        Conjugation(form: "Polite", japanese: "飲みます", meaning: "I drink"),
        Conjugation(form: "Polite Past", japanese: "飲みました", meaning: "I drank"),
      ],
    ),
    Verb(
      english: "Go",
      kanji: "行く",
      hiragana: "いく",
      romaji: "iku",
      explanation: "Use this verb when talking about going somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "行く", meaning: "to go"),
        Conjugation(form: "Polite", japanese: "行きます", meaning: "I go"),
        Conjugation(form: "Polite Past", japanese: "行きました", meaning: "I went"),
      ],
    ),
    Verb(
      english: "Come",
      kanji: "来る",
      hiragana: "くる",
      romaji: "kuru",
      explanation: "Use this verb when talking about coming somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "来る", meaning: "to come"),
        Conjugation(form: "Polite", japanese: "来ます", meaning: "I come"),
        Conjugation(form: "Polite Past", japanese: "来ました", meaning: "I came"),
      ],
    ),
    Verb(
      english: "Wash",
      kanji: "洗う",
      hiragana: "あらう",
      romaji: "arau",
      explanation:
          "Use this verb when talking about washing things like hands, dishes, or clothes.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "洗う", meaning: "to wash"),
        Conjugation(form: "Polite", japanese: "洗います", meaning: "I wash"),
        Conjugation(
          form: "Polite Past",
          japanese: "洗いました",
          meaning: "I washed",
        ),
      ],
    ),
    Verb(
      english: "Eat",
      kanji: "食べる",
      hiragana: "たべる",
      romaji: "taberu",
      explanation: "Use this verb when talking about eating food.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "食べる", meaning: "to eat"),
        Conjugation(form: "Polite", japanese: "食べます", meaning: "I eat"),
        Conjugation(form: "Polite Past", japanese: "食べました", meaning: "I ate"),
      ],
    ),
    Verb(
      english: "Drink",
      kanji: "飲む",
      hiragana: "のむ",
      romaji: "nomu",
      explanation: "Use this verb when talking about drinking liquids.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "飲む", meaning: "to drink"),
        Conjugation(form: "Polite", japanese: "飲みます", meaning: "I drink"),
        Conjugation(form: "Polite Past", japanese: "飲みました", meaning: "I drank"),
      ],
    ),
    Verb(
      english: "Go",
      kanji: "行く",
      hiragana: "いく",
      romaji: "iku",
      explanation: "Use this verb when talking about going somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "行く", meaning: "to go"),
        Conjugation(form: "Polite", japanese: "行きます", meaning: "I go"),
        Conjugation(form: "Polite Past", japanese: "行きました", meaning: "I went"),
      ],
    ),
    Verb(
      english: "Come",
      kanji: "来る",
      hiragana: "くる",
      romaji: "kuru",
      explanation: "Use this verb when talking about coming somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "来る", meaning: "to come"),
        Conjugation(form: "Polite", japanese: "来ます", meaning: "I come"),
        Conjugation(form: "Polite Past", japanese: "来ました", meaning: "I came"),
      ],
    ),
    Verb(
      english: "Wash",
      kanji: "洗う",
      hiragana: "あらう",
      romaji: "arau",
      explanation:
          "Use this verb when talking about washing things like hands, dishes, or clothes.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "洗う", meaning: "to wash"),
        Conjugation(form: "Polite", japanese: "洗います", meaning: "I wash"),
        Conjugation(
          form: "Polite Past",
          japanese: "洗いました",
          meaning: "I washed",
        ),
      ],
    ),
    Verb(
      english: "Eat",
      kanji: "食べる",
      hiragana: "たべる",
      romaji: "taberu",
      explanation: "Use this verb when talking about eating food.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "食べる", meaning: "to eat"),
        Conjugation(form: "Polite", japanese: "食べます", meaning: "I eat"),
        Conjugation(form: "Polite Past", japanese: "食べました", meaning: "I ate"),
      ],
    ),
    Verb(
      english: "Drink",
      kanji: "飲む",
      hiragana: "のむ",
      romaji: "nomu",
      explanation: "Use this verb when talking about drinking liquids.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "飲む", meaning: "to drink"),
        Conjugation(form: "Polite", japanese: "飲みます", meaning: "I drink"),
        Conjugation(form: "Polite Past", japanese: "飲みました", meaning: "I drank"),
      ],
    ),
    Verb(
      english: "Go",
      kanji: "行く",
      hiragana: "いく",
      romaji: "iku",
      explanation: "Use this verb when talking about going somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "行く", meaning: "to go"),
        Conjugation(form: "Polite", japanese: "行きます", meaning: "I go"),
        Conjugation(form: "Polite Past", japanese: "行きました", meaning: "I went"),
      ],
    ),
    Verb(
      english: "Come",
      kanji: "来る",
      hiragana: "くる",
      romaji: "kuru",
      explanation: "Use this verb when talking about coming somewhere.",
      conjugations: [
        Conjugation(form: "Dictionary", japanese: "来る", meaning: "to come"),
        Conjugation(form: "Polite", japanese: "来ます", meaning: "I come"),
        Conjugation(form: "Polite Past", japanese: "来ました", meaning: "I came"),
      ],
    ),
  ].obs;

  /// Pagination + search
  final RxInt pageIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final int itemsPerPage = 10;

  /// Filtered verbs
  List<Verb> get filteredVerbs {
    if (searchQuery.value.isEmpty) {
      return verbs;
    }
    return verbs.where((verb) {
      return verb.english.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          verb.kanji.contains(searchQuery.value) ||
          verb.hiragana.contains(searchQuery.value) ||
          verb.romaji.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  /// Current page verbs
  List<Verb> get currentPageItems {
    final filtered = filteredVerbs;
    int start = pageIndex.value * itemsPerPage;
    int end = start + itemsPerPage;
    end = end > filtered.length ? filtered.length : end;
    return filtered.sublist(start, end);
  }

  /// Pagination helpers
  bool get hasNextPage =>
      (pageIndex.value + 1) * itemsPerPage < filteredVerbs.length;
  bool get hasPreviousPage => pageIndex.value > 0;
  int get totalPages => (filteredVerbs.length / itemsPerPage).ceil();
  int get currentPage => pageIndex.value + 1;

  void nextPage() {
    if (hasNextPage) pageIndex.value++;
  }

  void previousPage() {
    if (hasPreviousPage) pageIndex.value--;
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      pageIndex.value = page;
    }
  }

  /// Search functions
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    pageIndex.value = 0;
  }

  void clearSearch() {
    searchQuery.value = '';
    pageIndex.value = 0;
  }

  /// Get verb by index
  Verb getVerbAt(int index) {
    return currentPageItems[index];
  }
}
