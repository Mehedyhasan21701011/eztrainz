import 'package:get/get.dart';

import '../controllers/listenpage_controller.dart';

class ListenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListenpageController>(
      () => ListenpageController(),
    );
  }
}
