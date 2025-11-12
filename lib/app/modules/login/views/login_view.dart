import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/largetext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:eztrainz/app/utils/widget/smalltext.dart';
import 'package:eztrainz/app/utils/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                      largeText("Welcome"),
                      smallText("Login to your account"),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                customTextField(
                  label: "Email",
                  hintText: "Enter your email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Password Field
                Obx(
                  () => customTextField(
                    label: "Password",
                    hintText: "Enter your password",
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[600],
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Remember Me + Forgot Password
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (val) =>
                                controller.toggleRememberMe(val ?? false),
                            activeColor: const Color(0xFF2196F3),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          smallText("Remember me", opaCity: 0.85),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // handle forgot password
                        },
                        child: smallText("Forgot Password", opaCity: 0.6),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Login Button
                primaryButton(
                  "Login",
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      // You can connect Firebase or API here
                      Get.toNamed(Routes.COURSEOVERVIEW);
                    }
                  },
                ),

                const SizedBox(height: 24),

                // Continue with
                Center(child: smallText("Or continue with", opaCity: 0.7)),
                const SizedBox(height: 24),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildLoginButton('assets/google.png', 'Google'),
                    buildLoginButton('assets/facebook.png', 'Facebook'),
                    buildLoginButton('assets/apple.png', 'Apple'),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    smallText("Don't have an account?", opaCity: 0.7),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTERPAGE);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(String image, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 45,
      decoration: BoxDecoration(
        color: TColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 22, width: 22),
          const SizedBox(width: 4),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
