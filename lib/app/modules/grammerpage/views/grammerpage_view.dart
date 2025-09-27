import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grammerpage_controller.dart';

class GrammerpageView extends GetView<GrammerpageController> {
  const GrammerpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GrammerpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GrammerpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
