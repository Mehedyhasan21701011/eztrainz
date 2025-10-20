import 'package:get/get.dart';

class SentenceExample {
  final String japanese;
  final String english;

  SentenceExample({required this.japanese, required this.english});
}

class SentencexampleController extends GetxController {
  final examples = <SentenceExample>[
    SentenceExample(japanese: '本を読みます。', english: 'I read a book.'),
    SentenceExample(japanese: '音楽を聞きます。', english: 'I listen to music.'),
    SentenceExample(japanese: '映画を見ます。', english: 'I watch a movie.'),
    SentenceExample(japanese: '日本語を勉強します。', english: 'I study Japanese.'),
    SentenceExample(japanese: '手紙を書きます。', english: 'I write a letter.'),
    SentenceExample(japanese: '友だちと話します。', english: 'I talk with my friend.'),
    SentenceExample(japanese: 'コーヒーを飲みます。', english: 'I drink coffee.'),
    SentenceExample(japanese: '犬と遊びます。', english: 'I play with my dog.'),
    SentenceExample(japanese: '買い物に行きます。', english: 'I go shopping.'),
    SentenceExample(japanese: '車を運転します。', english: 'I drive a car.'),
    SentenceExample(japanese: '学校に行きます。', english: 'I go to school.'),
    SentenceExample(japanese: 'うちに帰ります。', english: 'I go home.'),
    SentenceExample(japanese: '写真を撮ります。', english: 'I take a picture.'),
    SentenceExample(japanese: 'テレビを見ます。', english: 'I watch TV.'),
    SentenceExample(japanese: '料理をします。', english: 'I cook.'),
    SentenceExample(japanese: '手を洗います。', english: 'I wash my hands.'),
    SentenceExample(japanese: '早く寝ます。', english: 'I go to bed early.'),
    SentenceExample(
      japanese: '朝、ジョギングをします。',
      english: 'I go jogging in the morning.',
    ),
  ].obs;

  final currentPage = 0.obs;
  final int pageSize = 10;

  List<SentenceExample> get paginatedExamples {
    final start = currentPage.value * pageSize;
    final end = start + pageSize;
    return examples.sublist(
      start,
      end > examples.length ? examples.length : end,
    );
  }

  bool get hasMore => (currentPage.value + 1) * pageSize < examples.length;

  void nextPage() {
    if (hasMore) currentPage.value++;
  }

  void resetPage() {
    currentPage.value = 0;
  }
}
