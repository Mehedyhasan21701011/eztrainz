// ignore_for_file: use_super_parameters

import 'package:eztrainz/app/modules/gamepage/controllers/gamepage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamepageView extends GetView<GameController> {
  const GamepageView({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Play Game", style: Heading.heading2),
                Image.asset("assets/madel.png", height: 32, width: 32),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              "Play, test, and master your Japanese skills",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: controller.progressValue.value,
                  minHeight: 6,
                  backgroundColor: TColors.buttonBackground,
                  valueColor: AlwaysStoppedAnimation<Color>(TColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Beginner"),
                Text("Level 1"),
                Text("Level 2"),
                Text("Level 3"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.games.length,
                  itemBuilder: (context, index) {
                    final game = controller.games[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                        right: 4,
                        left: 4,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              41,
                              41,
                              41,
                            ).withOpacity(0.3),
                            blurRadius: 2,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Left side: Avatar, title, subtitle, and progress
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 20,
                                      child: SizedBox(), //put image
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            game.title,
                                            style: Heading.heading1,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            game.subtitle,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                170,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: game.progress,
                                    minHeight: 6,
                                    backgroundColor: Colors.blue[50],
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.blueAccent,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                if (game.progress.toDouble() * 100 > 0)
                                  Text(
                                    "${(game.progress.toDouble() * 100).toStringAsFixed(0)}% complete",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(170, 0, 0, 0),
                                    ),
                                  )
                                else
                                  const Text(
                                    "Unlock at level 1",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(170, 0, 0, 0),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Right side: Lock icon and Play button
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => controller.toggleLock(index),
                                child: Icon(
                                  game.isLocked
                                      ? Icons.lock_outline
                                      : Icons.lock_open_rounded,
                                  color: Colors.blueAccent,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  if (!game.isLocked) {
                                    Get.snackbar(
                                      "Game",
                                      "Starting ${game.title}...",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Locked",
                                      "Unlock this level first!",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: game.isLocked
                                        ? TColors.buttonBackground
                                        : TColors.buttonSecondary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Play",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: TColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
