import 'package:eztrainz/app/modules/particlepage/controllers/particlepage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/heading2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticlesView extends GetView<ParticlesController> {
  const ParticlesView({super.key});

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            heading2("Essential Particles for JLPT N5 Level"),
            const SizedBox(height: 16),

            // Particles Grid
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = controller.currentPageItems;

                if (items.isEmpty) {
                  return _buildEmptyState();
                }

                return GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.71,
                  ),
                  itemBuilder: (context, index) {
                    final particle = items[index];
                    return _buildParticleCard(particle, index);
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // Pagination Controls
            Obx(() => _buildPaginationControls()),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No particles found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: controller.clearSearch,
            child: const Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildParticleCard(Particle particle, int index) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.PARTICLEDETAILS, arguments: index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                particle.symbol,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  particle.meaning,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous Button
        controller.hasPreviousPage
            ? TextButton(
                onPressed: controller.hasPreviousPage
                    ? controller.previousPage
                    : null,
                style: TextButton.styleFrom(),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // shrink to fit content
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: TColors.primary,
                    ),
                    SizedBox(width: 4),
                    Text('Previous', style: TextStyle(color: TColors.primary)),
                  ],
                ),
              )
            : Text(""),

        // Next Button
        controller.hasNextPage
            ? TextButton(
                onPressed: controller.hasNextPage ? controller.nextPage : null,
                style: TextButton.styleFrom(),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // shrink to fit content
                  children: const [
                    Text('Next', style: TextStyle(color: TColors.primary)),
                    SizedBox(width: 4), // spacing between text and icon
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: TColors.primary,
                    ),
                  ],
                ),
              )
            : Text(""),
      ],
    );
  }
}
