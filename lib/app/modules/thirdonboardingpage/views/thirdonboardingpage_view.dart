import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/heading2.dart';
import 'package:eztrainz/app/utils/widget/mediumtext.dart';
import 'package:eztrainz/app/utils/widget/routebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/thirdonboardingpage_controller.dart';

class ThirdonboardingpageView extends GetView<ThirdonboardingpageController> {
  const ThirdonboardingpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Header
              Center(child: mediumText("Help us know you better")),

              const SizedBox(height: 20),

              // Logo image
              Center(
                child: Image.asset(
                  "assets/logo3.png",
                  width: 210,
                  height: 116,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 210,
                      height: 116,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Gender Section
              heading2("Gender"),
              const SizedBox(height: 8),
              _buildGenderSection(),

              const SizedBox(height: 20),

              // Age and Location Section
              _buildAgeLocationSection(),

              const SizedBox(height: 20),

              // Education Level Section
              _buildEducationSection(),

              const SizedBox(height: 20),

              // Profession Section
              _buildProfessionSection(),

              const SizedBox(height: 20),

              // Industry Section
              _buildIndustrySection(),

              const SizedBox(height: 40),

              // Navigation buttons
              _buildNavigationButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSection() {
    return Obx(() {
      return Row(
        children: List.generate(controller.genders.length, (index) {
          final gender = controller.genders[index];
          final isSelected = controller.selectedGender.value == gender;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.selectedGender.value = gender;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.buttonSecondary
                      : AppColors.buttonBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gender icons
                    _buildGenderIcon(index),
                    if (index != 2) const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        gender,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildGenderIcon(int index) {
    switch (index) {
      case 0: // Male
        return Image.asset(
          "assets/male.png",
          width: 20,
          height: 20,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.male, size: 20, color: Colors.blue);
          },
        );
      case 1: // Female
        return Image.asset(
          "assets/female.png",
          width: 20,
          height: 20,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.female, size: 20, color: Colors.pink);
          },
        );
      case 2: // Other
        return SizedBox();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAgeLocationSection() {
    return Row(
      children: [
        // Age Field
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading2("Age"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller.ageController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "32",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                  ),
                  onChanged: (value) {
                    controller.age.value = value;
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Location Field
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading2("Location"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller.locationController,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Enter your city",
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        "assets/location.png",
                        width: 20,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 20,
                    ),
                  ),
                  onChanged: (value) {
                    controller.location.value = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading2("Highest Level of Education"),
        const SizedBox(height: 8),
        Obx(
          () => GestureDetector(
            onTap: () => controller.showEducationPicker(Get.context!),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buttonBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.selectedEducation.value.isEmpty
                          ? "Select your education level"
                          : controller.selectedEducation.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.selectedEducation.value.isEmpty
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/dropdown.png",
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfessionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading2("Profession"),
        const SizedBox(height: 8),
        Obx(
          () => GestureDetector(
            onTap: () => controller.showProfessionPicker(Get.context!),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buttonBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.selectProfession.value.isEmpty
                          ? "Select your profession"
                          : controller.selectProfession.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.selectProfession.value.isEmpty
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/dropdown.png",
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndustrySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading2("Industry"),
        const SizedBox(height: 8),
        Obx(
          () => GestureDetector(
            onTap: () => controller.showIndustryPicker(Get.context!),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buttonBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.selectedIndustry.value.isEmpty
                          ? "Select your industry"
                          : controller.selectedIndustry.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.selectedIndustry.value.isEmpty
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/dropdown.png",
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        routeButton(
          "Next",
          onpress: () {
            handleNextButtonTap();
          },
          imgPath: "assets/start_arrow.png",
        ),
      ],
    );
  }

  void handleNextButtonTap() {
    if (_validateForm()) {
      Get.toNamed(Routes.REGISTERPAGE);
    } else {
      controller.validateAndContinue();
    }
  }

  bool _validateForm() {
    return controller.selectedGender.value.isNotEmpty &&
        controller.age.value.isNotEmpty &&
        controller.location.value.isNotEmpty &&
        controller.selectedEducation.value.isNotEmpty &&
        controller.selectProfession.value.isNotEmpty &&
        controller.selectedIndustry.value.isNotEmpty;
  }
}
