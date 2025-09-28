import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/particlepage_controller.dart';

class ParticlepageView extends GetView<ParticlepageController> {
  const ParticlepageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParticlepageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ParticlepageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
