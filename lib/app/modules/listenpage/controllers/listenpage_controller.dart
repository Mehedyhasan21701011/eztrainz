import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class ListenpageController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  final RxInt currentPage = 0.obs;
  final RxInt selectedAnswer = (-1).obs;
  final RxBool isPlaying = false.obs;
  final RxBool showQuestion = true.obs;

  // For progress bar
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;

  final List<Map<String, dynamic>> audio = [
    {
      'audio': 'audio/audio_1.mp3',
      'title': 'Dai 1 ka Kaiwa',
      'subtitle': 'Dai 1 ka Kaiwa',
    },
  ];

  final List<Map<String, dynamic>> question = [
    {
      'question': 'What are the kids having for lunch?',
      'options': ['国', '年', '中'],
      'answerIndex': 2,
    },
    {
      'question': 'Where is the school?',
      'options': ['東', '西', '南'],
      'answerIndex': 0,
    },
    {
      'question': 'What time is it?',
      'options': ['朝', '昼', '夜'],
      'answerIndex': 1,
    },
  ];

  /// Pagination helpers
  bool get hasNextPage => currentPage.value < question.length - 1;
  bool get hasPreviousPage => currentPage.value > 0;

  void goToPage(int index) {
    if (index >= 0 && index < question.length) {
      currentPage.value = index;
      selectedAnswer.value = -1;
    }
  }

  void nextPage() {
    if (hasNextPage) {
      showQuestion.value = true;
      currentPage.value++;
      selectedAnswer.value = -1;
    }
  }

  void previousPage() {
    if (hasPreviousPage) {
      showQuestion.value = true;
      currentPage.value--;
      selectedAnswer.value = -1;
    }
  }

  bool isCorrect(int index) {
    if (currentPage.value >= question.length) return false;
    return index == question[currentPage.value]['answerIndex'];
  }

  void selectAnswer(int index) {
    // Prevent changing answer only if current answer is correct
    if (selectedAnswer.value != -1 && isCorrect(selectedAnswer.value)) {
      return;
    }

    selectedAnswer.value = index;

    // Auto-advance only on correct answer
    if (isCorrect(index)) {
      Future.delayed(const Duration(seconds: 1), () {
        if (hasNextPage) {
          nextPage();
        } else {
          showQuestion.value = false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Listen for duration changes
    audioPlayer.onDurationChanged.listen((d) => totalDuration.value = d);
    audioPlayer.onPositionChanged.listen((p) => currentPosition.value = p);
    audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      currentPosition.value = Duration.zero;
    });
  }

  Future<void> playAudio(String path) async {
    try {
      await audioPlayer.stop();

      if (GetPlatform.isWeb) {
        await audioPlayer.play(UrlSource(path));
      } else {
        // AssetSource expects path without 'assets/' prefix
        await audioPlayer.play(AssetSource(path));
      }
      isPlaying.value = true;
    } catch (e) {
      isPlaying.value = false;
    }
  }

  Future<void> togglePlayPause() async {
    if (audio.isEmpty) return;

    if (isPlaying.value) {
      await audioPlayer.pause();
      isPlaying.value = false;
    } else {
      if (currentPosition.value.inMilliseconds > 0) {
        await audioPlayer.resume();
      } else {
        await playAudio(audio[0]['audio']);
      }
      isPlaying.value = true;
    }
  }

  void seekTo(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  void skipForward() {
    final newPosition = currentPosition.value + const Duration(seconds: 10);
    if (newPosition < totalDuration.value) {
      seekTo(newPosition.inMilliseconds.toDouble());
    }
  }

  void skipBackward() {
    final newPosition = currentPosition.value - const Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      seekTo(newPosition.inMilliseconds.toDouble());
    } else {
      seekTo(0);
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
