import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoScreen extends StatefulWidget {
  final String videoUrl;

  const YouTubeVideoScreen({super.key, required this.videoUrl});

  @override
  State<YouTubeVideoScreen> createState() => _YouTubeVideoScreenState();
}

class _YouTubeVideoScreenState extends State<YouTubeVideoScreen> {
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "";
    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Watch Video")),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _ytController,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return Column(children: [player]);
        },
      ),
    );
  }
}
