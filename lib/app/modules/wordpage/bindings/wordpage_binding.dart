import 'package:get/get.dart';

import '../controllers/wordpage_controller.dart';

class WordpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WordpageController>(
      () => WordpageController(),
    );
  }
}
