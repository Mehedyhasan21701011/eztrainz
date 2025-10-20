import 'package:get/get.dart';

class NounpronounController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Map<String, dynamic>> Data = [
    {
      "name": "Noun",
      "kanji": "名詞",
      "romaji": "(meishi)",
      "kana": "(めいし)",
      "description":
          "Nouns are words that name people, places, or things. In Japanese, nouns don’t change for plural — the same word can mean one or many.",
    },
    {
      "name": "Pronoun",
      "kanji": "代名詞",
      "romaji": "(daimeishi)",
      "kana": "(だいめいし)",
      "description":
          "Pronouns replace nouns like “I,” “you,” or “this.” They can change depending on the speaker, situation, or level of politeness.",
    },
  ];

  final List<Map<String, dynamic>> nouns = [
    {
      'category': 'People',
      'japanese': '人',
      'hiragana': 'ひと',
      'description': 'Words for people and relationships',
      'icon': '👥',
      'color': 0xFF4CAF50,
      'subcategories': [
        {
          'title': 'Family Members',
          'items': [
            {'word': '父', 'reading': 'ちち', 'meaning': 'father'},
            {'word': '母', 'reading': 'はは', 'meaning': 'mother'},
            {'word': '兄', 'reading': 'あに', 'meaning': 'older brother'},
            {'word': '姉', 'reading': 'あね', 'meaning': 'older sister'},
          ],
        },
        {
          'title': 'Social Relations',
          'items': [
            {'word': '友達', 'reading': 'ともだち', 'meaning': 'friend'},
            {'word': '先生', 'reading': 'せんせい', 'meaning': 'teacher'},
            {'word': '学生', 'reading': 'がくせい', 'meaning': 'student'},
          ],
        },
      ],
    },
    {
      'category': 'Objects',
      'japanese': '物',
      'hiragana': 'もの',
      'description': 'Words for everyday items and objects',
      'icon': '📦',
      'color': 0xFF2196F3,
      'subcategories': [
        {
          'title': 'School Items',
          'items': [
            {'word': '本', 'reading': 'ほん', 'meaning': 'book'},
            {'word': '鉛筆', 'reading': 'えんぴつ', 'meaning': 'pencil'},
            {'word': '机', 'reading': 'つくえ', 'meaning': 'desk'},
          ],
        },
      ],
    },
    {
      'category': 'Time',
      'japanese': '時間',
      'hiragana': 'じかん',
      'description': 'Words for time, days, and abstract ideas',
      'icon': '⏰',
      'color': 0xFFFF9800,
      'subcategories': [
        {
          'title': 'Time Words',
          'items': [
            {'word': '今日', 'reading': 'きょう', 'meaning': 'today'},
            {'word': '明日', 'reading': 'あした', 'meaning': 'tomorrow'},
            {'word': '昨日', 'reading': 'きのう', 'meaning': 'yesterday'},
          ],
        },
      ],
    },
  ];

  // Pronouns data structure
  final List<Map<String, dynamic>> pronoun = [
    {
      'category': 'Personal',
      'japanese': '人称',
      'hiragana': 'にんしょう',
      'description': 'Represents people or relationships clearly',
      'icon': '👤',
      'color': 0xFF9C27B0,
      'subcategories': [
        {
          'title': 'First Person',
          'items': [
            {'word': '私', 'reading': 'わたし', 'meaning': 'I/me (polite)'},
            {'word': '僕', 'reading': 'ぼく', 'meaning': 'I/me (casual, male)'},
            {'word': '俺', 'reading': 'おれ', 'meaning': 'I/me (informal, male)'},
          ],
        },
        {
          'title': 'Second Person',
          'items': [
            {'word': 'あなた', 'reading': 'あなた', 'meaning': 'you'},
            {'word': '君', 'reading': 'きみ', 'meaning': 'you (casual)'},
          ],
        },
        {
          'title': 'Third Person',
          'items': [
            {'word': '彼', 'reading': 'かれ', 'meaning': 'he/him'},
            {'word': '彼女', 'reading': 'かのじょ', 'meaning': 'she/her'},
          ],
        },
      ],
    },
    {
      'category': 'Demonstrative',
      'japanese': '指示',
      'hiragana': 'しじ',
      'description': 'Indicates objects, places, or things',
      'icon': '👉',
      'color': 0xFFE91E63,
      'subcategories': [
        {
          'title': 'Ko-So-A-Do Series',
          'items': [
            {'word': 'これ', 'reading': 'これ', 'meaning': 'this (near speaker)'},
            {'word': 'それ', 'reading': 'それ', 'meaning': 'that (near listener)'},
            {'word': 'あれ', 'reading': 'あれ', 'meaning': 'that (far from both)'},
            {'word': 'どれ', 'reading': 'どれ', 'meaning': 'which'},
          ],
        },
        {
          'title': 'Location',
          'items': [
            {'word': 'ここ', 'reading': 'ここ', 'meaning': 'here'},
            {'word': 'そこ', 'reading': 'そこ', 'meaning': 'there'},
            {'word': 'あそこ', 'reading': 'あそこ', 'meaning': 'over there'},
            {'word': 'どこ', 'reading': 'どこ', 'meaning': 'where'},
          ],
        },
      ],
    },
    {
      'category': 'Interrogative',
      'japanese': '疑問',
      'hiragana': 'ぎもん',
      'description': 'Used to ask questions directly',
      'icon': '❓',
      'color': 0xFFFF5722,
      'subcategories': [
        {
          'title': 'Question Words',
          'items': [
            {'word': '誰', 'reading': 'だれ', 'meaning': 'who'},
            {'word': '何', 'reading': 'なに/なん', 'meaning': 'what'},
            {'word': 'いつ', 'reading': 'いつ', 'meaning': 'when'},
            {'word': 'どこ', 'reading': 'どこ', 'meaning': 'where'},
            {'word': 'なぜ', 'reading': 'なぜ', 'meaning': 'why'},
            {'word': 'どう', 'reading': 'どう', 'meaning': 'how'},
          ],
        },
      ],
    },
  ];
}
