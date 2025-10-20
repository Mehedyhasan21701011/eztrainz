import 'package:eztrainz/app/modules/adjective/controllers/adjective_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdjectiveView extends GetView<AdjectiveController> {
  const AdjectiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/setting.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: buildAdjectiveContent(),
      ),
    );
  }

  /// Builds the main adjective page content
  Widget buildAdjectiveContent() {
    final controller = Get.find<AdjectiveController>();
    final data = controller.Data[0];

    return ListView(
      children: [
        participleIdentity(data),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          "${data["description"]}",
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
        const SizedBox(height: 30),
        card(controller.adjectives),
      ],
    );
  }

  Widget card(List<Map<String, dynamic>> adjectives) {
    return ListView.builder(
      itemCount: adjectives.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final adjective = adjectives[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(2, 2), // right + bottom only
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        adjective['japanese'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: TColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        adjective['hiragana'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: TColors.primary,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    Center(
                      child: Text(
                        "${adjective['category']}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                adjective['description'],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
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
              Text(
                "${data["name"]}",
                style: const TextStyle(color: TColors.primary, fontSize: 16),
              ),
              Text(
                "${data["kanji"]}",
                style: const TextStyle(color: TColors.primary, fontSize: 16),
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
                style: const TextStyle(color: TColors.primary, fontSize: 16),
              ),
              Text(
                "${data["kana"]}",
                style: const TextStyle(color: TColors.primary, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
