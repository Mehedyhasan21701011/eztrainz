import 'package:get/get.dart';

import '../controllers/adjective_controller.dart';

class AdjectiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdjectiveController>(
      () => AdjectiveController(),
    );
  }
}
