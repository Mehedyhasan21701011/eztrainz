import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/practicegrammer_controller.dart';

class PracticegrammerView extends GetView<PracticegrammerController> {
  const PracticegrammerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PracticegrammerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PracticegrammerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
