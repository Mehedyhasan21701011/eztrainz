import 'package:get/get.dart';

import '../controllers/particledetails_controller.dart';

class ParticledetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticledetailsController>(
      () => ParticledetailsController(),
    );
  }
}
