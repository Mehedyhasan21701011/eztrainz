import 'package:eztrainz/app/modules/common/youtube.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString selectedLevel = "N1".obs;
  final Rxn<int> expandedIndex = Rxn<int>();
  final RxList<Map<String, dynamic>> lessons = <Map<String, dynamic>>[].obs;
  final RxString videoUrl = "".obs;

  /// Full lesson data for all levels
  final Map<String, List<Map<String, dynamic>>> allLessons = {
    "N1": [
      {
        "title": "Introduction to N1",
        "progress": 0.0,
        "videos": [
          {
            "url": "https://www.youtube.com/shorts/tLZjL-dMH_g",
            "watched": false,
          },
          {
            "url": "https://www.youtube.com/shorts/tLZjL-dMH_g",
            "watched": false,
          },
          {
            "url": "https://www.youtube.com/shorts/tLZjL-dMH_g",
            "watched": false,
          },
        ],
      },
      {
        "title": "Basic Grammar N1",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/abc123", "watched": false},
          {"url": "https://www.youtube.com/shorts/abc456", "watched": false},
        ],
      },
      {
        "title": "Bocabolary N1",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/abc123", "watched": false},
          {"url": "https://www.youtube.com/shorts/abc456", "watched": false},
        ],
      },
    ],
    "N2": [
      {
        "title": "Introduction to N2",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n2a", "watched": false},
          {"url": "https://www.youtube.com/shorts/n2b", "watched": false},
        ],
      },
      {
        "title": "Grammar Practice N2",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n2c", "watched": false},
          {"url": "https://www.youtube.com/shorts/n2d", "watched": false},
          {"url": "https://www.youtube.com/shorts/n2e", "watched": false},
        ],
      },
      {
        "title": "Vocabulary N2",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n2f", "watched": false},
        ],
      },
    ],
    "N3": [
      {
        "title": "Introduction to N3",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n3a", "watched": false},
          {"url": "https://www.youtube.com/shorts/n3b", "watched": false},
        ],
      },
      {
        "title": "Grammar Practice N3",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n3c", "watched": false},
          {"url": "https://www.youtube.com/shorts/n3d", "watched": false},
        ],
      },
      {
        "title": "Vocabulary N3",
        "progress": 0.0,
        "videos": [
          {"url": "https://www.youtube.com/shorts/n3e", "watched": false},
          {"url": "https://www.youtube.com/shorts/n3f", "watched": false},
          {"url": "https://www.youtube.com/shorts/n3g", "watched": false},
        ],
      },
    ],
  };

  void onInit() {
    super.onInit();
    // Load default lessons (N1)
    lessons.assignAll(allLessons[selectedLevel.value]!);
  }

  void toggleExpand(int? index) {
    if (index == null) {
      expandedIndex.value = null;
      return;
    }
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }

  void markVideoWatched(int lessonIndex, int videoIndex) {
    final lesson = Map<String, dynamic>.from(lessons[lessonIndex]);
    final videos = List<Map<String, dynamic>>.from(lesson["videos"]);

    videos[videoIndex] = {
      ...videos[videoIndex],
      "watched": !(videos[videoIndex]["watched"] as bool),
    };

    final watchedCount = videos.where((v) => v["watched"] == true).length;
    lesson["videos"] = videos;
    lesson["progress"] = watchedCount / videos.length;

    lessons[lessonIndex] = lesson; // This updates the RxList properly
  }

  void changeLevel(String level) {
    selectedLevel.value = level;
    expandedIndex.value = null;
    lessons.assignAll(allLessons[level]!); // Update lessons list
  }

  double getProgressForLesson(int lessonIndex) {
    return lessons[lessonIndex]["progress"] as double;
  }

  void playVideo(String url) {
    videoUrl.value = url; // store it in case you need it globally
    Get.to(() => YouTubeVideoScreen(videoUrl: url));
  }
}
