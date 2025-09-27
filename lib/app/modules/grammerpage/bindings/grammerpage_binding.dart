import 'package:get/get.dart';

import '../controllers/grammerpage_controller.dart';

class GrammerpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrammerpageController>(
      () => GrammerpageController(),
    );
  }
}
