import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style to match background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent for gradient
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // blend with background
        elevation: 0,
        title: Image.asset("assets/logo.png", width: 180),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40), // space under appbar
              // Hero Text
              Column(
                children: [
                  Text(
                    "EZPZ Japanesy!",
                    textAlign: TextAlign.center,
                    style: Heading.heading2,
                  ),
                  SizedBox(height: 12),
                ],
              ),

              // Illustration / Logo2
              Image.asset("assets/logo2.png", height: 320, width: 320),

              // Get Started Button
              GestureDetector(
                onTap: () {
                  Get.offNamed(
                    Routes.SECONDONBOARDINGPAGE,
                  ); // Navigate to Home and remove onboarding from stack
                },

                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFC00), // bright yellow
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        "assets/start_arrow.png",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
