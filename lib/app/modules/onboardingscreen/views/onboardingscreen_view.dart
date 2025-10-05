import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/largetext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style to match background
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40), // space under appbar
              // Hero Text
              Column(
                children: [
                  largeText("EZPZ Japanesy!", letterSpace: 1.2),
                  SizedBox(height: 12),
                ],
              ),
              Image.asset("assets/logo2.png", height: 320, width: 320),
              primaryButton(
                "Get Started",
                width: double.infinity,
                imgPath: "assets/start_arrow.png",
                onTap: () {
                  Get.offNamed(Routes.SECONDONBOARDINGPAGE);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
