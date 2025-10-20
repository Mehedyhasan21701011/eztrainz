import 'package:get/get.dart';

import '../controllers/adverb_controller.dart';

class AdverbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdverbController>(
      () => AdverbController(),
    );
  }
}
