import 'package:get/get.dart';

class Particle {
  final String symbol;
  final String meaning;
  final String pronunciation;
  final List<String> examples; // Changed from String to List<String>
  final String structure;
  final String hiragana;
  final String explanation;

  Particle({
    required this.symbol,
    required this.meaning,
    required this.pronunciation,
    required this.examples, // Updated
    required this.structure,
    required this.hiragana,
    required this.explanation,
  });
}

class ParticlesController extends GetxController {
  var selectedIndex = 0.obs; // 0 = Structure, 1 = Verb

  // ✅ JSON-like card data

  final List<Particle> particles = [
    Particle(
      symbol: 'は',
      meaning: 'Topic Marker',
      pronunciation: 'wa',
      hiragana: 'は',
      structure: 'Noun + は + Predicate',
      examples: [
        '私は学生です。(I am a student.)',
        '今日は暑いです。(Today is hot.)',
        'この本は面白いです。(This book is interesting.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'が',
      meaning: 'Subject Marker',
      pronunciation: 'ga',
      hiragana: 'が',
      structure: 'Subject + が + Verb',
      examples: [
        '雨が降っています。(It is raining.)',
        '猫が好きです。(I like cats.)',
        '誰が来ますか？(Who is coming?)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'を',
      meaning: 'Object Marker',
      pronunciation: 'wo/o',
      hiragana: 'を',
      structure: 'Noun + を + Verb',
      examples: [
        '本を読みます。(I read a book.)',
        'ご飯を食べます。(I eat rice.)',
        '映画を見ます。(I watch a movie.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'に',
      meaning: 'Direction/Time',
      pronunciation: 'ni',
      hiragana: 'に',
      structure: 'Place/Time + に + Verb',
      examples: [
        '学校に行きます。(I go to school.)',
        '七時に起きます。(I wake up at 7 o\'clock.)',
        '友達に会います。(I meet a friend.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'で',
      meaning: 'Place of Action/Means',
      pronunciation: 'de',
      hiragana: 'で',
      structure: 'Place + で + Verb',
      examples: [
        '図書館で勉強します。(I study at the library.)',
        'バスで行きます。(I go by bus.)',
        '家で映画を見ます。(I watch a movie at home.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'へ',
      meaning: 'Direction/Goal',
      pronunciation: 'he/e',
      hiragana: 'へ',
      structure: 'Destination + へ + Verb',
      examples: [
        '東京へ行きます。(I go to Tokyo.)',
        '学校へ向かいます。(I head to school.)',
        '友達の家へ行きます。(I go to a friend\'s house.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'と',
      meaning: 'And/With',
      pronunciation: 'to',
      hiragana: 'と',
      structure: 'Noun + と + Noun / Noun + と + Verb',
      examples: [
        '友達と映画を見ます。(I watch movies with friends.)',
        'リンゴとバナナを買いました。(I bought apples and bananas.)',
        '母と話します。(I talk with my mother.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'も',
      meaning: 'Also/Too',
      pronunciation: 'mo',
      hiragana: 'も',
      structure: 'Noun + も + Verb',
      examples: [
        '私も行きます。(I will go too.)',
        '彼も来ました。(He also came.)',
        '猫も好きです。(I also like cats.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'から',
      meaning: 'From/Because',
      pronunciation: 'kara',
      hiragana: 'から',
      structure: 'Starting Point + から + Action / Reason + から + Result',
      examples: [
        '駅から歩きます。(I walk from the station.)',
        '雨だから行きません。(I won\'t go because it\'s raining.)',
        '九時から授業があります。(There is class from 9 o\'clock.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'まで',
      meaning: 'Until/To',
      pronunciation: 'made',
      hiragana: 'まで',
      structure: 'Ending Point + まで + Action',
      examples: [
        '5時まで働きます。(I work until 5 o\'clock.)',
        '駅まで歩きます。(I walk to the station.)',
        '授業は三時までです。(Class is until 3 o\'clock.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'や',
      meaning: 'And/etc',
      pronunciation: 'ya',
      hiragana: 'や',
      structure: 'Noun + や + Noun + など',
      examples: [
        'りんごやバナナを買います。(I buy apples, bananas, etc.)',
        '本やノートがあります。(There are books and notebooks.)',
        '猫や犬が好きです。(I like cats and dogs.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'の',
      meaning: 'Possessive/Modifier',
      pronunciation: 'no',
      hiragana: 'の',
      structure: 'Owner + の + Object',
      examples: [
        '私の本です。(It is my book.)',
        '彼の家は大きいです。(His house is big.)',
        '猫の耳は小さいです。(A cat\'s ears are small.)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'か',
      meaning: 'Question Marker',
      pronunciation: 'ka',
      hiragana: 'か',
      structure: 'Statement + か',
      examples: [
        '元気ですか？(Are you well?)',
        'これは本ですか？(Is this a book?)',
        '明日行きますか？(Will you go tomorrow?)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'ね',
      meaning: 'Confirmation Tag',
      pronunciation: 'ne',
      hiragana: 'ね',
      structure: 'Statement + ね',
      examples: [
        '美しいですね。(It\'s beautiful, isn\'t it?)',
        '寒いですね。(It\'s cold, isn\'t it?)',
        '楽しいですね。(It\'s fun, isn\'t it?)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
    Particle(
      symbol: 'よ',
      meaning: 'Assertion/Emphasis',
      pronunciation: 'yo',
      hiragana: 'よ',
      structure: 'Statement + よ',
      examples: [
        '頑張って！(Do your best!)',
        'これは本当ですよ。(This is true!)',
        '見てくださいよ。(Look at this!)',
      ],
      explanation:
          'The を particle marks the direct object of a verb. It shows what  receives the action. ',
    ),
  ];

  // Pagination and filter state
  final RxInt pageIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final int itemsPerPage = 10;

  // Filtered particles based on search
  List<Particle> get filteredParticles {
    if (searchQuery.value.isEmpty) {
      return particles;
    }
    return particles.where((particle) {
      return particle.symbol.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          particle.meaning.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          particle.pronunciation.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
    }).toList();
  }

  // Current page items
  List<Particle> get currentPageItems {
    final filtered = filteredParticles;
    int start = pageIndex.value * itemsPerPage;
    int end = start + itemsPerPage;
    end = end > filtered.length ? filtered.length : end;
    return filtered.sublist(start, end);
  }

  // Pagination helpers
  bool get hasNextPage =>
      (pageIndex.value + 1) * itemsPerPage < filteredParticles.length;

  bool get hasPreviousPage => pageIndex.value > 0;

  int get totalPages => (filteredParticles.length / itemsPerPage).ceil();

  int get currentPage => pageIndex.value + 1;

  // Navigation methods
  void nextPage() {
    if (hasNextPage) {
      pageIndex.value++;
    }
  }

  void previousPage() {
    if (hasPreviousPage) {
      pageIndex.value--;
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      pageIndex.value = page;
    }
  }

  // Search functionality
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    pageIndex.value = 0; // Reset to first page when searching
  }

  void clearSearch() {
    searchQuery.value = '';
    pageIndex.value = 0;
  }

  // Get particle details for modal/dialog
  Particle getParticleAt(int index) {
    return currentPageItems[index];
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    // Any initialization logic
  }
}
