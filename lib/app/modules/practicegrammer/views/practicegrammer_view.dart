import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/practicegrammer_controller.dart';

class PracticegrammerView extends GetView<PracticegrammerController> {
  const PracticegrammerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/profile.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: const Center(
        child: Text(
          'PracticegrammerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
