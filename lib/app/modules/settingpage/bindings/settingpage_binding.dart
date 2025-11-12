import 'package:eztrainz/app/modules/settingpage/controllers/settingpage_controller.dart';
import 'package:get/get.dart';

class SettingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
