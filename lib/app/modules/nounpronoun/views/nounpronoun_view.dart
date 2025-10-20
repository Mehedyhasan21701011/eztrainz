import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/tab.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/nounpronoun_controller.dart';

class NounpronounView extends GetView<NounpronounController> {
  const NounpronounView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/profile.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.selectedIndex.value = 0,
                      child: buildTab(
                        "Noun",
                        controller.selectedIndex.value == 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.selectedIndex.value = 1,
                      child: buildTab(
                        "Pronoun",
                        controller.selectedIndex.value == 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.selectedIndex.value == 0) {
                  return buildNounContent();
                } else {
                  return buildPronounContent();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNounContent() {
    final Controller = Get.find<NounpronounController>();
    final data = Controller.Data[0];
    return Column(
      children: [
        participleIdentity(data),
        SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          "${data["description"]}",
          style: TextStyle(color: Colors.black87),
        ),
        SizedBox(height: 20),
        card(Controller.nouns),
      ],
    );
  }

  Widget buildPronounContent() {
    final Controller = Get.find<NounpronounController>();
    final data = Controller.Data[1];
    return Column(
      children: [
        participleIdentity(data),
        SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          "${data["description"]}",
          style: TextStyle(color: Colors.black87),
        ),
        SizedBox(height: 20),

        pCard(Controller.pronoun),
      ],
    );
  }

  Widget card(List<Map<String, dynamic>> nouns) {
    return Expanded(
      child: ListView.builder(
        itemCount: nouns.length,
        itemBuilder: (context, index) {
          final noun = nouns[index];
          return Column(
            children: [
              Container(
                width: 170,
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // shadow color
                      offset: const Offset(3, 3), // → right: 3, ↓ bottom: 3
                      blurRadius: 2, // soft blur
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.right,
                                  noun['japanese'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: TColors.primary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.left,
                                  noun['hiragana'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: TColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              noun['category'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(noun['description']),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget pCard(List<Map<String, dynamic>> pronouns) {
    return Expanded(
      child: ListView.builder(
        itemCount: pronouns.length,
        itemBuilder: (context, index) {
          final pronoun = pronouns[index];
          return Column(
            children: [
              Container(
                width: 170,
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // shadow color
                      offset: const Offset(3, 3), // → right: 3, ↓ bottom: 3
                      blurRadius: 2, // soft blur
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                pronoun['japanese'],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: TColors.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(width: 30),
                            Center(
                              child: Text(
                                pronoun['hiragana'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: TColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            pronoun['category'],
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(pronoun['description']),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget participleIdentity(Map<String, dynamic> data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${data["name"]}", style: TextStyle(color: TColors.primary)),
              Text(
                "${data["kanji"]}",
                style: TextStyle(color: TColors.primary),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data["romaji"]}",
                style: TextStyle(color: TColors.primary),
              ),
              Text("${data["kana"]}", style: TextStyle(color: TColors.primary)),
            ],
          ),
        ),
      ],
    );
  }
}
