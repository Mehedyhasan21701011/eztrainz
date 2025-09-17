import 'package:get/get.dart';

import '../controllers/list_content_controller.dart';

class ListContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListContentController>(() => ListContentController());
  }
}
