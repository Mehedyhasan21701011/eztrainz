import 'package:get/get.dart';

import '../controllers/verbdetails_controller.dart';

class VerbdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerbdetailsController>(
      () => VerbdetailsController(),
    );
  }
}
