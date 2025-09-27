import 'package:get/get.dart';

import '../controllers/gamepage_controller.dart';

class GamepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GamepageController>(
      () => GamepageController(),
    );
  }
}
