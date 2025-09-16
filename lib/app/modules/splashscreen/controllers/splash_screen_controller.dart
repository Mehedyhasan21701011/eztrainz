// splash_screen_controller.dart
import 'package:get/get.dart';
import 'dart:async';
import 'package:eztrainz/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 5), () {
      Get.offNamed(Routes.ONBOARDINGSCREEN); // Navigate after 3s
    });
  }
}
