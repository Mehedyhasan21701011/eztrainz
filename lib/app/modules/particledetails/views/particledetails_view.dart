import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/particledetails_controller.dart';

class ParticledetailsView extends GetView<ParticledetailsController> {
  const ParticledetailsView({super.key});

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
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Reactive Card
          Obx(() {
            final particle = controller
                .particlecontroller
                .currentPageItems[controller.particleId.value];

            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Text(
                        "${particle.symbol} Particle",
                        style: const TextStyle(
                          fontSize: 22,
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Explanation
                    const Text(
                      "Explanation",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      particle.explanation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Structure
                    const Text(
                      "Structure",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        particle.structure,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Examples
                    const Text(
                      "Examples",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: particle.examples
                            .map(
                              (example) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ✅ circular icon (bullet)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.only(
                                        top: 6,
                                      ), // align with text
                                      decoration: const BoxDecoration(
                                        color: Colors
                                            .blue, // change color if needed
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    // ✅ Example text
                                    Expanded(
                                      child: Text(
                                        example,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Next / Previous Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button
                OutlinedButton(
                  onPressed: () {
                    if (controller.particleId.value > 0) {
                      controller.particleId.value--;
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: TColors.primary),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/leftArrow.png",
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Previous",
                        style: TextStyle(color: TColors.primary),
                      ),
                    ],
                  ),
                ),

                // Next Button
                OutlinedButton(
                  onPressed: () {
                    if (controller.particleId.value <
                        controller.particlecontroller.currentPageItems.length -
                            1) {
                      controller.particleId.value++;
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: TColors.primary),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text("Next", style: TextStyle(color: TColors.primary)),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/rightArrow.png",
                        width: 18,
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
