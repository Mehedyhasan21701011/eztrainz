import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/list_content_controller.dart';

class ListContentView extends GetView<ListContentController> {
  const ListContentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely handle null arguments
    final arguments = Get.arguments;
    if (arguments == null) {
      return _buildErrorScaffold('No content data provided');
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildVideoSection(),
            const SizedBox(height: 10),
            _buildTitleSection(),
            const SizedBox(height: 10),
            _buildOptionSection(),
            const SizedBox(height: 20),
            Obx(
              () => controller.displayVisibility.value
                  ? _buildDisplaySection()
                  : controller.cardVisibility.value
                  ? _buildCardSection()
                  : _buildCongratulationSection(),
            ),
            const SizedBox(height: 20),
            _buildBottomMessage(),
          ],
        ),
      ),
    );
  }

  /// Build error scaffold when arguments are missing
  Widget _buildErrorScaffold(String message) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: const Text(
          "EzTrainz",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: Get.back,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.HOME);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
      ),
      title: Image.asset(
        "assets/logo.png",
        width: 150,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            "EzTrainz",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          );
        },
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {

          },
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 238, 244, 250),
              radius: 20,
              child: Icon(Icons.person, size: 30, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: controller.ytController,
                showVideoProgressIndicator: false,
                progressIndicatorColor: Colors.blueAccent,
                progressColors: ProgressBarColors(
                  playedColor: Colors.blueAccent,
                  handleColor: Colors.blueAccent,
                ),
              ),
            ),
          ),
      
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Text(
              controller.lessonTitle.value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(221, 32, 31, 31),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionSection() {
    return Obx(() {
      final kanjiList = controller.kanjiOptions;
      final selected = controller.selectedKanji.value;

      return SizedBox(
        height: 70,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth =
                kanjiList.length * 80 + ((kanjiList.length - 1) * 12);

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: totalWidth < constraints.maxWidth
                    ? (constraints.maxWidth - totalWidth) / 2
                    : 16,
              ),
              itemCount: kanjiList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final kanji = kanjiList[index];
                final isSelected = selected == kanji;

                return GestureDetector(
                  onTap: () => {
                    controller.selectKanji(kanji),
                    controller.displayVisibility.value = true,
                    controller.cardVisibility.value = false,
                  },
                  child: Card(
                    color: isSelected
                        ? Color.fromARGB(255, 246, 245, 133)
                        : const Color.fromARGB(255, 244, 249, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Center(
                        child: Text(
                          kanji,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildDisplaySection() {
    return Column(
      children: [
        // Big Kanji character inside a styled container
        Obx(
          () => Text(
            controller.currentKanji.value,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Meaning with nice typography
        Obx(
          () => Text(
            controller.kanjiMeaning.value,
            style: const TextStyle(
              fontSize: 22,
              color: Color.fromARGB(221, 32, 31, 31),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 20),

        _buildPronunciationSection(),
      ],
    );
  }

  Widget _buildPronunciationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text("Kun'yomi"),
                const SizedBox(height: 5),
                Obx(
                  () => PronunciationButton(
                    pronunciation: controller.kunyomi.value,
                    color: Colors.yellow[300]!,
                    onTap: () => controller.playAudio('kunyomi'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                const Text("On'yomi"),
                const SizedBox(height: 5),
                Obx(
                  () => PronunciationButton(
                    pronunciation: controller.onyomi.value,
                    color: Colors.yellow[300]!,
                    onTap: () => controller.playAudio('onyomi'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMessage() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 249, 255),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          controller.displayVisibility.value
              ? "Great! You've learned a new Kanji."
              : controller.cardVisibility.value
              ? controller.isAnsSelected.value
                    ? controller.isAnswered.value
                          ? "Correct! 🎉"
                          : "Incorrect. Try again!"
                    : "Select the correct meaning"
              : "Contratulations! 🎉",
          // controller.displayVisibility.value
          //     ? "あの山は高いです"
          //     : controller.cardVisibility.value
          //     ? "Select the correct meaning"
          //     : controller.isAnswered.value
          //     ? "Contratulations! 🎉"
          //     : "Try Again!",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue[400],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Card(
      color: const Color.fromARGB(255, 246, 245, 133),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(controller.options.length, (index) {
              return _buildOptionItem(index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(int index) {
    return Obx(() {
      final isSelected = controller.selectedOption.value == index;
      return GestureDetector(
        onTap: () => _handleOptionTap(index),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 225, 239, 253)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${String.fromCharCode(97 + index)}) ${controller.options[index]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              _buildOptionIcon(isSelected),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildOptionIcon(bool isSelected) {
    if (!isSelected) {
      return const Icon(Icons.cancel, color: Colors.transparent);
    }
    return Icon(
      controller.isAnswered.value ? Icons.check_circle : Icons.cancel,
      color: controller.isAnswered.value ? Colors.green : Colors.red,
    );
  }

  void _handleOptionTap(int index) {
    controller.selectedOption.value = index;
    controller.isAnsSelected.value = true;

    if (controller.options[index] == controller.answer) {
      controller.isAnswered.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        controller.cardVisibility.value = false;
        Future.delayed(const Duration(seconds: 2), () {
          controller.displayVisibility.value = true;
        });
      });
    } else {
      controller.isAnswered.value = false;
    }
  }

  Widget _buildCongratulationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/congratulations.png", width: 150, height: 150),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class PronunciationButton extends StatelessWidget {
  final String pronunciation;
  final Color color;
  final VoidCallback onTap;

  const PronunciationButton({
    super.key,
    required this.pronunciation,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  pronunciation,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.volume_up, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}
