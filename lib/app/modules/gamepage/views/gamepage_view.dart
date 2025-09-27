import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gamepage_controller.dart';

class GamepageView extends GetView<GamepageController> {
  const GamepageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GamepageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GamepageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
