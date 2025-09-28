import 'package:get/get.dart';

import '../controllers/particlepage_controller.dart';

class ParticlepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticlepageController>(
      () => ParticlepageController(),
    );
  }
}
