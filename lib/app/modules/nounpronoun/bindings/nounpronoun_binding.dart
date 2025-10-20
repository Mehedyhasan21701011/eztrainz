import 'package:get/get.dart';

import '../controllers/nounpronoun_controller.dart';

class NounpronounBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NounpronounController>(
      () => NounpronounController(),
    );
  }
}
