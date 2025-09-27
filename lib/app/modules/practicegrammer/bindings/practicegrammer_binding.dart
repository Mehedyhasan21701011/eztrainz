import 'package:get/get.dart';

import '../controllers/practicegrammer_controller.dart';

class PracticegrammerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PracticegrammerController>(
      () => PracticegrammerController(),
    );
  }
}
