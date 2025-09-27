import 'package:get/get.dart';

import '../controllers/secondonboardingpage_controller.dart';

class SecondonboardingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondonboardingpageController>(
      () => SecondonboardingpageController(),
    );
  }
}
