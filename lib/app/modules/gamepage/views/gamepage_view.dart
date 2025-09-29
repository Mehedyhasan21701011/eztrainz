import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gamepage_controller.dart';

class GamepageView extends GetView<GamepageController> {
  const GamepageView({super.key});
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
        child: Text('GamepageView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
