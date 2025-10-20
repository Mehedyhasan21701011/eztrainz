import 'package:get/get.dart';

import '../controllers/sentence_controller.dart';

class SentenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SentenceController>(
      () => SentenceController(),
    );
  }
}
