import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget buildVideoSection(youtubecontroller) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: youtubecontroller,
              showVideoProgressIndicator: false,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.blueAccent,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    ),
  );
}
