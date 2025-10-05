import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoWidget extends StatefulWidget {
  final RxString videoUrl; // make it reactive
  final bool autoPlay;
  final bool showProgressIndicator;

  const YouTubeVideoWidget({
    super.key,
    required this.videoUrl,
    this.autoPlay = false,
    this.showProgressIndicator = true,
  });

  @override
  State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
}

class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
  late YoutubePlayerController ytController;

  @override
  void initState() {
    super.initState();
    ytController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl.value) ?? "",
      flags: YoutubePlayerFlags(autoPlay: widget.autoPlay, mute: false),
    );

    // Reactively listen for URL changes
    ever(widget.videoUrl, (String newUrl) {
      final videoId = YoutubePlayer.convertUrlToId(newUrl) ?? "";
      if (videoId.isNotEmpty) {
        ytController.load(videoId); // load the new video
        ytController.pause(); // immediately pause to prevent autoplay
      }
    });
  }

  @override
  void dispose() {
    ytController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // adjust radius as needed
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: ytController,
          showVideoProgressIndicator: widget.showProgressIndicator,
        ),
        builder: (context, player) {
          return player;
        },
      ),
    );
  }
}
