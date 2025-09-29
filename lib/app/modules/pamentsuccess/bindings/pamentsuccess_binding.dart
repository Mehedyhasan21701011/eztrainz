import 'package:get/get.dart';

import '../controllers/pamentsuccess_controller.dart';

class PamentsuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PamentsuccessController>(
      () => PamentsuccessController(),
    );
  }
}
