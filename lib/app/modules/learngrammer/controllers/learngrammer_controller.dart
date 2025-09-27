import 'package:get/get.dart';

class LearngrammerController extends GetxController {
  var selectedIndex = 0.obs; // 0 = Structure, 1 = Verb

  // ✅ JSON-like card data
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
}
