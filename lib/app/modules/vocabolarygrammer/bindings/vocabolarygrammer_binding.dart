import 'package:get/get.dart';

import '../controllers/vocabolarygrammer_controller.dart';

class VocabolarygrammerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VocabolaryController>(
      () => VocabolaryController(),
    );
  }
}
