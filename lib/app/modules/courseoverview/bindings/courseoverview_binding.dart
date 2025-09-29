import 'package:get/get.dart';

import '../controllers/courseoverview_controller.dart';

class CourseoverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseoverviewController>(
      () => CourseoverviewController(),
    );
  }
}
