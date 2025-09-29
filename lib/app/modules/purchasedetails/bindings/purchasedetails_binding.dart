import 'package:get/get.dart';

import '../controllers/purchasedetails_controller.dart';

class PurchasedetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasedetailsController>(
      () => PurchasedetailsController(),
    );
  }
}
