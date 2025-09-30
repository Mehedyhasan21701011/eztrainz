import 'package:eztrainz/app/modules/particlepage/controllers/particlepage_controller.dart';
import 'package:get/get.dart';

class ParticledetailsController extends GetxController {
  final particlecontroller = Get.find<ParticlesController>();

  final particleId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    particleId.value = Get.arguments as int;
  }
}
