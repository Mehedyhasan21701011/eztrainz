import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdonboardingpageController extends GetxController {
  // Observable variables
  final RxString selectedGender = ''.obs;
  final RxString age = ''.obs;
  final RxString location = ''.obs;
  final RxString selectedEducation = ''.obs;
  final RxString selectProfession = ''.obs;
  final RxString selectedIndustry = ''.obs;

  // Text controllers
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Data lists
  final List<String> genders = ['Male', 'Female', 'Other'];

  final List<String> educationLevels = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD/Doctorate',
    'Professional Degree',
    'Other',
  ];

  final List<String> industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Manufacturing',
    'Retail',
    'Construction',
    'Transportation',
    'Government',
    'Non-profit',
    'Other',
  ];

  final List<String> professions = [
    'Teacher',
    'Doctor',
    'Farmer',
    'Nurse',
    'Driver',
    'Engineer', // Fixed typo from 'Enginer'
    'Businessman',
    'Hawker', // Fixed typo from 'Hoker'
    'Police',
    'Army',
    'Other',
  ];

  @override
  void onInit() {
    super.onInit();

    // Listen to text controller changes
    ageController.addListener(() {
      age.value = ageController.text;
    });

    locationController.addListener(() {
      location.value = locationController.text;
    });
  }

  @override
  void onClose() {
    ageController.dispose();
    locationController.dispose();
    super.onClose();
  }

  void showEducationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Education Level',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...educationLevels.map(
                (level) => ListTile(
                  title: Text(level),
                  onTap: () {
                    selectedEducation.value = level;
                    Navigator.pop(
                      context,
                    ); // Use Navigator.pop instead of Get.back()
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showIndustryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Industry',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...industries.map(
                (industry) => ListTile(
                  title: Text(industry),
                  onTap: () {
                    selectedIndustry.value = industry;
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showProfessionPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Profession',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...professions.map(
                (profession) => ListTile(
                  title: Text(profession),
                  onTap: () {
                    selectProfession.value = profession;
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndContinue() {
    if (selectedGender.value.isEmpty) {
      Get.snackbar('Error', 'Please select your gender');
      return;
    }

    if (age.value.isEmpty) {
      Get.snackbar('Error', 'Please enter your age');
      return;
    }

    // Validate age is a number and within reasonable range
    final ageInt = int.tryParse(age.value);
    if (ageInt == null || ageInt < 1 || ageInt > 120) {
      Get.snackbar('Error', 'Please enter a valid age');
      return;
    }

    if (location.value.isEmpty) {
      Get.snackbar('Error', 'Please enter your location');
      return;
    }

    if (selectedEducation.value.isEmpty) {
      Get.snackbar('Error', 'Please select your education level');
      return;
    }

    if (selectProfession.value.isEmpty) {
      Get.snackbar('Error', 'Please select your profession');
      return;
    }

    if (selectedIndustry.value.isEmpty) {
      Get.snackbar('Error', 'Please select your industry');
      return;
    }

    // All validation passed, continue to next page
    Get.snackbar('Success', 'Profile information saved!');
    // Navigate to next page or save data
  }

  Map<String, dynamic> getUserData() {
    return {
      'gender': selectedGender.value,
      'age': age.value,
      'location': location.value,
      'education': selectedEducation.value,
      'profession': selectProfession.value,
      'industry': selectedIndustry.value,
    };
  }
}
