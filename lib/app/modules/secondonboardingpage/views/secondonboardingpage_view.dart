import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/mediumtext.dart';
import 'package:eztrainz/app/utils/widget/routebutton.dart';
import 'package:eztrainz/app/utils/widget/smalltext.dart';
import 'package:eztrainz/app/utils/widget/youtube.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/secondonboardingpage_controller.dart';

class SecondonboardingpageView extends GetView<SecondonboardingpageController> {
  const SecondonboardingpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo3.png", height: 100, width: 200),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: YouTubeVideoWidget(videoUrl: controller.videoId),
          ),
          SizedBox(height: 20),
          mediumText("Japanese Made Eazy!"),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: smallText(
                "With EZTrainz you can now learn Japanese from anywhere at your time and pace.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              // ✅ Removed Expanded wrapper
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                routeButton(
                  "Next",
                  onpress: () {
                    Get.toNamed(Routes.THIRDONBOARDINGPAGE);
                  },
                  imgPath: "assets/start_arrow.png",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
