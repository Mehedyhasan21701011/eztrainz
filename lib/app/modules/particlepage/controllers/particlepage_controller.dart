import 'package:get/get.dart';

class Particle {
  final String symbol;
  final String meaning;
  final String pronunciation;
  final String example;
  final String exampleTranslation;

  Particle({
    required this.symbol,
    required this.meaning,
    required this.pronunciation,
    required this.example,
    required this.exampleTranslation,
  });
}

class ParticlesController extends GetxController {
  // List of particle items with enhanced data
  final List<Particle> particles = [
    Particle(
      symbol: 'は',
      meaning: 'Topic Marker',
      pronunciation: 'wa',
      example: '私は学生です。',
      exampleTranslation: 'I am a student.',
    ),
    Particle(
      symbol: 'が',
      meaning: 'Subject Marker',
      pronunciation: 'ga',
      example: '雨が降っています。',
      exampleTranslation: 'It is raining.',
    ),
    Particle(
      symbol: 'を',
      meaning: 'Object Marker',
      pronunciation: 'wo/o',
      example: '本を読みます。',
      exampleTranslation: 'I read a book.',
    ),
    Particle(
      symbol: 'に',
      meaning: 'Direction',
      pronunciation: 'ni',
      example: '学校に行きます。',
      exampleTranslation: 'I go to school.',
    ),
    Particle(
      symbol: 'で',
      meaning: 'Place of Action/Means',
      pronunciation: 'de',
      example: '図書館で勉強します。',
      exampleTranslation: 'I study at the library.',
    ),
    Particle(
      symbol: 'へ',
      meaning: 'Direction/Goal',
      pronunciation: 'he/e',
      example: '東京へ行きます。',
      exampleTranslation: 'I go to Tokyo.',
    ),
    Particle(
      symbol: 'と',
      meaning: 'And/With',
      pronunciation: 'to',
      example: '友達と映画を見ます。',
      exampleTranslation: 'I watch movies with friends.',
    ),
    Particle(
      symbol: 'も',
      meaning: 'Also/Too',
      pronunciation: 'mo',
      example: '私も行きます。',
      exampleTranslation: 'I will go too.',
    ),
    Particle(
      symbol: 'から',
      meaning: 'From/Because',
      pronunciation: 'kara',
      example: '駅から歩きます。',
      exampleTranslation: 'I walk from the station.',
    ),
    Particle(
      symbol: 'まで',
      meaning: 'Until/To',
      pronunciation: 'made',
      example: '5時まで働きます。',
      exampleTranslation: 'I work until 5 o\'clock.',
    ),
    Particle(
      symbol: 'や',
      meaning: 'And/etc',
      pronunciation: 'ya',
      example: 'りんごやバナナを買います。',
      exampleTranslation: 'I buy apples, bananas, etc.',
    ),
    Particle(
      symbol: 'の',
      meaning: 'Possessive/Modifier',
      pronunciation: 'no',
      example: '私の本です。',
      exampleTranslation: 'It is my book.',
    ),
    Particle(
      symbol: 'か',
      meaning: 'Question Marker',
      pronunciation: 'ka',
      example: '元気ですか？',
      exampleTranslation: 'Are you well?',
    ),
    Particle(
      symbol: 'ね',
      meaning: 'Confirmation Tag',
      pronunciation: 'ne',
      example: '美しいですね。',
      exampleTranslation: 'It\'s beautiful, isn\'t it?',
    ),
    Particle(
      symbol: 'よ',
      meaning: 'Assertion/Emphasis',
      pronunciation: 'yo',
      example: '頑張って！',
      exampleTranslation: 'Do your best!',
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


}
