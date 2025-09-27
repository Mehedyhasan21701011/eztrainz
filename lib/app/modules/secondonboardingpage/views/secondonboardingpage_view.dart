import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/bannarheading.dart';
import 'package:eztrainz/app/utils/widget/headingtext.dart';
import 'package:eztrainz/app/utils/widget/subtitle.dart';
import 'package:eztrainz/app/utils/widget/videosection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/secondonboardingpage_controller.dart';

class SecondonboardingpageView extends GetView<SecondonboardingpageController> {
  const SecondonboardingpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png", width: 140),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo3.png", height: 100, width: 200),
              ],
            ),
            SizedBox(height: 20),
            buildVideoSection(controller.ytController),
            SizedBox(height: 20),
            bannerHeading("Japanese Made Eazy!"),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  "With EZTrainz you can now learn Japanese from anywhere at your time and pace.",
                  textAlign: TextAlign.center, // center-align text
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.8),
                    height: 1.5, // optional line spacing
                  ),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.THIRDONBOARDINGPAGE);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.THIRDONBOARDINGPAGE);
                    },
                    child: Image.asset(
                      "assets/start_arrow.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
