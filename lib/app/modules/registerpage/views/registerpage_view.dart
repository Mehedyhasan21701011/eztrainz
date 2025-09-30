import 'package:eztrainz/app/modules/registerpage/controllers/registerpage_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/largetext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:eztrainz/app/utils/widget/smalltext.dart';
import 'package:eztrainz/app/utils/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      largeText("Register"),
                      smallText("Create your new account"),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                customTextField(
                  label: "Name",
                  hintText: "Enter your name",
                  controller: controller.nameController,
                ),
                SizedBox(height: 24),
                customTextField(
                  label: "Email",
                  hintText: "Enter your email",
                  controller: controller.emailController,
                ),
                SizedBox(height: 24),

                // Password Field
                Obx(
                  () => customTextField(
                    label: "Password",
                    hintText: "Enter your password",
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordVisible.value
                        ? false
                        : true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[600],
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                //checkBox
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: controller.toggleRememberMe,
                        activeColor: const Color(0xFF2196F3),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      smallText("Remember me", opaCity: 0.85),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                primaryButton(
                  "Create Account",
                  onTap: () {
                    Get.toNamed(Routes.COURSEOVERVIEW);
                  },
                ),
                const SizedBox(height: 24),

                // // Already have account
                // Center(
                //   child: TextButton(
                //     onPressed: () {
                //       // Navigate to login screen
                //       Get.back();
                //     },
                //     child: const Text(
                //       'Already have an account? Sign In',
                //       style: TextStyle(color: Color(0xFF2196F3), fontSize: 14),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
