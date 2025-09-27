// splash_screen_controller.dart
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  var state = ScreenState.loading.obs;
  @override
  void onInit() async {
    // Delay for 3 seconds before navigating
    await Future.delayed(Duration(seconds: 3));
    state.value = ScreenState.idle;
    Get.offNamed(Routes.ONBOARDINGSCREEN);

    super.onInit();
  }
}

enum ScreenState { loading, idle }
