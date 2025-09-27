import 'package:get/get.dart';

import '../controllers/learngrammer_controller.dart';

class LearngrammerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LearngrammerController>(
      () => LearngrammerController(),
    );
  }
}
