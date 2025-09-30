import 'package:eztrainz/app/modules/learngrammer/controllers/learngrammer_controller.dart';
import 'package:get/get.dart';

class VerbdetailsController extends GetxController {
  final learngrammercontroller = Get.find<LearngrammerController>();
  final verbId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    verbId.value = Get.arguments as int;
  }
}
