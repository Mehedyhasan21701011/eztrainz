import 'package:get/get.dart';

class Verb {
  final String english;
  final String kanji;
  final String hiragana;
  final String romaji;
  final String explanation;
  final PoliteForm politeForm;
  final PlainForm plainForm;
  final TeForm teForm;

  Verb({
    required this.english,
    required this.kanji,
    required this.hiragana,
    required this.romaji,
    required this.explanation,
    required this.politeForm,
    required this.plainForm,
    required this.teForm,
  });
}

class PoliteForm {
  final String presentPositive;
  final String presentNegative;
  final String pastPositive;
  final String pastNegative;

  PoliteForm({
    required this.presentPositive,
    required this.presentNegative,
    required this.pastPositive,
    required this.pastNegative,
  });
}

class PlainForm {
  final String presentPositive;
  final String presentNegative;
  final String pastPositive;
  final String pastNegative;

  PlainForm({
    required this.presentPositive,
    required this.presentNegative,
    required this.pastPositive,
    required this.pastNegative,
  });
}

class TeForm {
  final String connective;
  final String request;
  final String progressive;

  TeForm({
    required this.connective,
    required this.request,
    required this.progressive,
  });
}

class LearngrammerController extends GetxController {
  var selectedIndex = 0.obs; // 0 = Structure, 1 = Verb

  /// Grammar cards
  final List<Map<String, String>> grammarCards = [
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
      "description":
          "Learn how \"i\" and \"na\" adjectives shape descriptions.",
    },
    {
      "title": "Adverbs",
      "description": "Combine words to express complete ideas.",
    },
    {
      "title": "Sentence Foundation",
      "description": "Build basic Japanese sentences with polite endings.",
    },
  ];

  /// Verb list
  var verbs = <Verb>[
    Verb(
      english: "to wash",
      kanji: "洗います",
      hiragana: "あらいます",
      romaji: "araimasu",
      explanation:
          "Use this verb when talking about washing things like hands or dishes.",
      politeForm: PoliteForm(
        presentPositive: "洗います",
        presentNegative: "洗いません",
        pastPositive: "洗いました",
        pastNegative: "洗いませんでした",
      ),
      plainForm: PlainForm(
        presentPositive: "洗う",
        presentNegative: "洗わない",
        pastPositive: "洗った",
        pastNegative: "洗わなかった",
      ),
      teForm: TeForm(
        connective: "洗って",
        request: "洗ってください",
        progressive: "洗っています",
      ),
    ),
    Verb(
      english: "to eat",
      kanji: "食べる",
      hiragana: "たべる",
      romaji: "taberu",
      explanation: "Use this verb when talking about eating food.",
      politeForm: PoliteForm(
        presentPositive: "食べます",
        presentNegative: "食べません",
        pastPositive: "食べました",
        pastNegative: "食べませんでした",
      ),
      plainForm: PlainForm(
        presentPositive: "食べる",
        presentNegative: "食べない",
        pastPositive: "食べた",
        pastNegative: "食べなかった",
      ),
      teForm: TeForm(
        connective: "食べて",
        request: "食べてください",
        progressive: "食べています",
      ),
    ),
    Verb(
      english: "to drink",
      kanji: "飲む",
      hiragana: "のむ",
      romaji: "nomu",
      explanation: "Use this verb when talking about drinking liquids.",
      politeForm: PoliteForm(
        presentPositive: "飲みます",
        presentNegative: "飲みません",
        pastPositive: "飲みました",
        pastNegative: "飲みませんでした",
      ),
      plainForm: PlainForm(
        presentPositive: "飲む",
        presentNegative: "飲まない",
        pastPositive: "飲んだ",
        pastNegative: "飲まなかった",
      ),
      teForm: TeForm(
        connective: "飲んで",
        request: "飲んでください",
        progressive: "飲んでいます",
      ),
    ),
    Verb(
      english: "to go",
      kanji: "行く",
      hiragana: "いく",
      romaji: "iku",
      explanation: "Use this verb when talking about going somewhere.",
      politeForm: PoliteForm(
        presentPositive: "行きます",
        presentNegative: "行きません",
        pastPositive: "行きました",
        pastNegative: "行きませんでした",
      ),
      plainForm: PlainForm(
        presentPositive: "行く",
        presentNegative: "行かない",
        pastPositive: "行った",
        pastNegative: "行かなかった",
      ),
      teForm: TeForm(
        connective: "行って",
        request: "行ってください",
        progressive: "行っています",
      ),
    ),
    Verb(
      english: "to come",
      kanji: "来る",
      hiragana: "くる",
      romaji: "kuru",
      explanation: "Use this verb when talking about coming somewhere.",
      politeForm: PoliteForm(
        presentPositive: "来ます",
        presentNegative: "来ません",
        pastPositive: "来ました",
        pastNegative: "来ませんでした",
      ),
      plainForm: PlainForm(
        presentPositive: "来る",
        presentNegative: "来ない",
        pastPositive: "来た",
        pastNegative: "来なかった",
      ),
      teForm: TeForm(connective: "来て", request: "来てください", progressive: "来ています"),
    ),
  ].obs;

  /// Pagination + search
  final RxInt pageIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final int itemsPerPage = 6; // ✅ Show 4 verbs per page

  /// Filtered verbs
  List<Verb> get filteredVerbs {
    if (searchQuery.value.isEmpty) return verbs;
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

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    pageIndex.value = 0;
  }

  void clearSearch() {
    searchQuery.value = '';
    pageIndex.value = 0;
  }
}
