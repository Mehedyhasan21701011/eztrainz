import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/gamecard.dart';
import 'package:eztrainz/app/utils/widget/largetext.dart';
import 'package:eztrainz/app/utils/widget/mediumtext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:eztrainz/app/utils/widget/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/courseoverview_controller.dart';

class CourseoverviewView extends GetView<CourseoverviewController> {
  const CourseoverviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(leftIconPath: "assets/leftArrow.png"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mediumText("JLPT N5 Course"),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 230,
                        child: smallText(
                          "Master JLPT N5 with 20+ lessons and practice games",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              gameCard("assets/thumbN5_1.png"),
              SizedBox(height: 30),
              Text(
                "Overview",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: TColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/lesson.png",
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 20),
                            Text("20+ Lessons", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Image.asset(
                          "assets/lock.png",
                          height: 20,
                          width: 20,
                          color: TColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/time.png",
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 20),
                            Text("30+ Hours", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Image.asset(
                          "assets/lock.png",
                          height: 20,
                          width: 20,
                          color: TColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/madel.png",
                              color: Colors.black,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "10+ Practice Games",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/lock.png",
                          height: 20,
                          width: 20,
                          color: TColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/store.png",
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "10+ Practice Games",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/lock.png",
                          height: 20,
                          width: 20,
                          color: TColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              largeText("BDT 1499"),
              SizedBox(height: 10),
              primaryButton(
                "Buy Now",
                width: 230,
                radius: 16,
                onTap: () {
                  Get.toNamed(Routes.PURCHASEDETAILS);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
