import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/gamecard.dart';
import 'package:eztrainz/app/utils/widget/mediumtext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/pamentsuccess_controller.dart';

class PamentsuccessView extends GetView<PamentsuccessController> {
  const PamentsuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/setting.png",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [mediumText("JLPT N5 Course")],
                  ),
                ],
              ),
              SizedBox(height: 10),
              gameCard("assets/thumb_3.png"),
              SizedBox(height: 50),
              Text(
                "Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: TColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/selectbold.png",
                width: 50,
                height: 50,
                color: Colors.green,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Your Purchase was Successfull!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 50),
              primaryButton(
                "Continue Learning",
                width: 230,
                radius: 16,
                onTap: () {
                  Get.toNamed(Routes.HOME);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
