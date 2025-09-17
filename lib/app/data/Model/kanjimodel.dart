class KanjiModel {
  final String kanji;
  final String meaning;
  final String kunyomi;
  final String onyomi;
  final String exampleSentence;

  KanjiModel({
    required this.kanji,
    required this.meaning,
    required this.kunyomi,
    required this.onyomi,
    required this.exampleSentence,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) {
    return KanjiModel(
      kanji: json['kanji'] ?? '',
      meaning: json['meaning'] ?? '',
      kunyomi: json['kunyomi'] ?? '',
      onyomi: json['onyomi'] ?? '',
      exampleSentence: json['exampleSentence'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kanji': kanji,
      'meaning': meaning,
      'kunyomi': kunyomi,
      'onyomi': onyomi,
      'exampleSentence': exampleSentence,
    };
  }
}
