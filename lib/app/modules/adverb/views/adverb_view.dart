import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/adverb_controller.dart';

class AdverbView extends GetView<AdverbController> {
  const AdverbView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdverbView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdverbView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
