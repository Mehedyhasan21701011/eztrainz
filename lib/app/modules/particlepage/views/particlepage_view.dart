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
        onTap: () => _showParticleDetails(particle),
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
        TextButton(
          onPressed: controller.hasPreviousPage
              ? controller.previousPage
              : null,
          style: TextButton.styleFrom(
            foregroundColor: controller.hasPreviousPage
                ? TColors.primary
                : Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // shrink to fit content
            children: const [
              Icon(Icons.arrow_back_ios, size: 16),
              SizedBox(width: 4),
              Text('Previous'),
            ],
          ),
        ),

        // Page indicators (show only if multiple pages)
        if (controller.totalPages > 1) _buildPageIndicators(),

        // Next Button
        TextButton(
          onPressed: controller.hasNextPage ? controller.nextPage : null,
          style: TextButton.styleFrom(
            foregroundColor: controller.hasNextPage
                ? TColors.primary
                : Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // shrink to fit content
            children: const [
              Text('Next'),
              SizedBox(width: 4), // spacing between text and icon
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        controller.totalPages > 5 ? 5 : controller.totalPages,
        (index) {
          int pageNumber;
          if (controller.totalPages <= 5) {
            pageNumber = index;
          } else {
            // Smart pagination - show pages around current page
            int currentPage = controller.pageIndex.value;
            int start = currentPage - 2;
            if (start < 0) start = 0;
            if (start + 5 > controller.totalPages) {
              start = controller.totalPages - 5;
            }
            pageNumber = start + index;
          }

          bool isCurrentPage = pageNumber == controller.pageIndex.value;

          return GestureDetector(
            onTap: () => controller.goToPage(pageNumber),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCurrentPage ? TColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCurrentPage ? TColors.primary : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  '${pageNumber + 1}',
                  style: TextStyle(
                    color: isCurrentPage ? Colors.white : Colors.grey[700],
                    fontWeight: isCurrentPage
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showParticleDetails(Particle particle) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    particle.symbol,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Pronunciation
              Text(
                'Pronunciation: ${particle.pronunciation}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 12),

              // Meaning
              Text(
                'Meaning:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                particle.meaning,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              // Example
              Text(
                'Example:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        particle.example,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        particle.exampleTranslation,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Got it!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
