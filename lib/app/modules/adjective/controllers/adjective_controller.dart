import 'package:get/get.dart';

class AdjectiveController extends GetxController {
  final List<Map<String, dynamic>> Data = [
    {
      "name": "Adjective",
      "kanji": "（形容詞）",
      "romaji": "(Keiyoushi)",
      "kana": "けいようし",
      "description":
          "Adjectives describe the qualities, feelings, or conditions of things. In Japanese, they’re divided into two following  types ",
    },
  ];

  final List<Map<String, dynamic>> adjectives = [
    {
      'category': 'い-Adjectives',
      'japanese': '形容詞',
      'hiragana': 'けいようし',
      'description':
          'Describe states and feelings. They end in “い” and can change form for tense or negation.',
      'icon': '👀',
      'color': 0xFF4CAF50,
      'subcategories': [
        {
          'title': 'Describing People',
          'items': [
            {'word': 'きれい', 'reading': 'kirei', 'meaning': 'beautiful, clean'},
            {'word': 'かわいい', 'reading': 'kawaii', 'meaning': 'cute'},
            {
              'word': 'かっこいい',
              'reading': 'kakkoii',
              'meaning': 'cool, handsome',
            },
            {'word': 'みにくい', 'reading': 'minikui', 'meaning': 'ugly'},
          ],
        },
        {
          'title': 'Describing Things',
          'items': [
            {'word': '大きい', 'reading': 'おおきい', 'meaning': 'big'},
            {'word': '小さい', 'reading': 'ちいさい', 'meaning': 'small'},
            {'word': '新しい', 'reading': 'あたらしい', 'meaning': 'new'},
            {'word': '古い', 'reading': 'ふるい', 'meaning': 'old (not for people)'},
          ],
        },
      ],
    },
    {
      'category': 'な-Adjectives',
      'japanese': '感情の形容詞',
      'hiragana': 'なけいようし',
      'description':
          'Describe states and feelings. They end in “い” and can change form for tense or negation.',
      'icon': '😊',
      'color': 0xFF2196F3,
      'subcategories': [
        {
          'title': 'Positive Feelings',
          'items': [
            {'word': 'うれしい', 'reading': 'ureshii', 'meaning': 'happy'},
            {
              'word': 'たのしい',
              'reading': 'tanoshii',
              'meaning': 'fun, enjoyable',
            },
            {'word': 'やさしい', 'reading': 'yasashii', 'meaning': 'kind, gentle'},
          ],
        },
        {
          'title': 'Negative Feelings',
          'items': [
            {'word': 'かなしい', 'reading': 'kanashii', 'meaning': 'sad'},
            {'word': 'こわい', 'reading': 'kowai', 'meaning': 'scary'},
            {'word': 'つまらない', 'reading': 'tsumaranai', 'meaning': 'boring'},
          ],
        },
      ],
    },
  ];
}
