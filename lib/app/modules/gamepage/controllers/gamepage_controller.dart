import 'package:eztrainz/app/data/Model/gameModel.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  // Observable list of game data
  var games = <GameModel>[].obs;
  var progressValue = 0.05.obs; // 25% complete

  @override
  void onInit() {
    super.onInit();
    loadGames();
  }

  void loadGames() {
    // Example JSON data (you can fetch from API or local file)
    final List<Map<String, dynamic>> jsonData = [
      {
        "title": "Kanji Review",
        "subtitle": "Test your kanji skills.",
        "progress": 0.25,
        "isLocked": false,
      },
      {
        "title": "Vocabulary Check",
        "subtitle": "Refresh and recall key words.",
        "progress": 0.0,
        "isLocked": true,
      },
      {
        "title": "Particle Challenge",
        "subtitle": "Apply particles with accuracy.",
        "progress": 0.0,
        "isLocked": true,
      },
      {
        "title": "Sentence Builder",
        "subtitle": "Master your grammar usage.",
        "progress": 0.0,
        "isLocked": true,
      },
      {
        "title": "Pronunciation Drill",
        "subtitle": "Enhance your natural tone.",
        "progress": 0.0,
        "isLocked": true,
      },
    ];
    games.value = jsonData.map((e) => GameModel.fromJson(e)).toList();
  }

  void toggleLock(int index) {
    final updated = games[index];
    games[index] = GameModel(
      title: updated.title,
      subtitle: updated.subtitle,
      progress: updated.progress,
      isLocked: !updated.isLocked,
    );
  }
}
