import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/thirdonboardingpage_controller.dart';

class ThirdonboardingpageView extends GetView<ThirdonboardingpageController> {
  const ThirdonboardingpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdonboardingpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ThirdonboardingpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
