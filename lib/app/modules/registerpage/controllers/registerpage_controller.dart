import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  RxBool isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me checkbox
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Create account function
  Future<void> createAccount() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Here you would typically call your registration API
        // Example:
        // await AuthService.register(
        //   name: nameController.text,
        //   email: emailController.text,
        //   password: passwordController.text,
        // );

        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to next screen or clear form
        clearForm();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to create account. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    rememberMe.value = false;
    isPasswordVisible.value = false;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
