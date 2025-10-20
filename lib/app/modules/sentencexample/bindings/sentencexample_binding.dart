import 'package:get/get.dart';

import '../controllers/sentencexample_controller.dart';

class SentencexampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SentencexampleController>(
      () => SentencexampleController(),
    );
  }
}
