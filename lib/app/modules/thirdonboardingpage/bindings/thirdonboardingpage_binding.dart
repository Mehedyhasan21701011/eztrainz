import 'package:get/get.dart';

import '../controllers/thirdonboardingpage_controller.dart';

class ThirdonboardingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirdonboardingpageController>(
      () => ThirdonboardingpageController(),
    );
  }
}
