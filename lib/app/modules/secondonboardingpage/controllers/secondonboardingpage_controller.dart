import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SecondonboardingpageController extends GetxController {
  // YoutubePlayerController? ytController;
  final RxString videoId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeYoutubeController();
  }

  void _initializeYoutubeController() {
    String url = "https://www.youtube.com/watch?v=ivRsYsVPPJ4";
    videoId.value = YoutubePlayer.convertUrlToId(url)!;
  }
}
