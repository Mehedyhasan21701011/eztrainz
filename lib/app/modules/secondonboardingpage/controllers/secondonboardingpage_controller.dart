import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SecondonboardingpageController extends GetxController {
  YoutubePlayerController? ytController;

  @override
  void onInit() {
    super.onInit();
    _initializeYoutubeController();
  }

  void _initializeYoutubeController() {
    const Url = "https://www.youtube.com/shorts/tLZjL-dMH_g";
    final videoId = YoutubePlayer.convertUrlToId(Url);

    if (videoId == null) return;

    if (ytController == null) {
      // First time initialization
      ytController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    } else {
      // Just load new video without disposing controller
      ytController!.load(videoId);
    }

    update();
  }

  @override
  void onClose() {
    ytController?.dispose(); // ✅ Dispose to prevent memory leaks
    super.onClose();
  }
}
