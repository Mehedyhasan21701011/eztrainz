import 'package:eztrainz/app/modules/splashscreen/controllers/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.state.value == ScreenState.loading
            ? Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 300,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
