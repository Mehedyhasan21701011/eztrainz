import 'package:get/get.dart';

class SentenceWord {
  final String japanese;
  final String romaji;
  final String english;
  final String type;

  SentenceWord({
    required this.japanese,
    required this.romaji,
    required this.english,
    required this.type,
  });
}

class SentenceExample {
  final String japanese;
  final String english;

  SentenceExample({required this.japanese, required this.english});
}

class SentenceController extends GetxController {
  final selectedWords = <SentenceWord>[].obs;

  final currentSentence = ''.obs;
  final currentTranslation = ''.obs;

  // Available word options
  final subjectWords = <SentenceWord>[
    SentenceWord(
      japanese: '主語',
      romaji: 'しゅご',
      english: 'Subject',
      type: 'subject',
    ),
    SentenceWord(japanese: '私は', romaji: 'わたしは', english: 'I', type: 'subject'),
  ].obs;

  final objectWords = <SentenceWord>[
    SentenceWord(
      japanese: '目的語',
      romaji: 'もくてきご',
      english: 'Object',
      type: 'object',
    ),
    SentenceWord(
      japanese: 'ごはん',
      romaji: 'ごはん',
      english: 'rice',
      type: 'object',
    ),
  ].obs;

  final verbWords = <SentenceWord>[
    SentenceWord(japanese: '動詞', romaji: 'どうし', english: 'Verb', type: 'verb'),
    SentenceWord(
      japanese: '食べます',
      romaji: 'たべます',
      english: 'eat',
      type: 'verb',
    ),
  ].obs;

  // Examples
  final examples = <SentenceExample>[
    SentenceExample(japanese: '朝ごはんを食べます。', english: 'I eat breakfast.'),
    SentenceExample(japanese: '水を飲みます。', english: 'I drink water.'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with default sentence
    buildDefaultSentence();
  }

  void buildDefaultSentence() {
    selectedWords.clear();
    selectedWords.addAll([
      subjectWords[1], // 私は
      objectWords[1], // ごはん
      verbWords[1], // 食べます
    ]);
    updateSentence();
  }

  void selectWord(SentenceWord word, int position) {
    if (position < selectedWords.length) {
      selectedWords[position] = word;
    } else {
      selectedWords.add(word);
    }
    updateSentence();
  }

  void updateSentence() {
    if (selectedWords.length >= 3) {
      // Japanese sentence structure: Subject + Object + Verb
      currentSentence.value =
          '${selectedWords[0].japanese}${selectedWords[1].japanese}を${selectedWords[2].japanese}。';

      currentTranslation.value =
          '${selectedWords[0].english} ${selectedWords[2].english} ${selectedWords[1].english}.';
    }
  }

  void clearSentence() {
    selectedWords.clear();
    currentSentence.value = '';
    currentTranslation.value = '';
  }

  void resetToDefault() {
    buildDefaultSentence();
  }
}
