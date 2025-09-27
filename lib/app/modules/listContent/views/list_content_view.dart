import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
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
      appBar: appbar(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        final title = controller.lessonTitle.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lesson Title
            Expanded(
              child: Text(
                title,
                style: Heading.heading3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }),
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
                    elevation: 0, // removes shadow
                    surfaceTintColor: Colors.transparent,
                    color: isSelected
                        ? const Color(0xFFF6F585)
                        : const Color(0xFFC4E0FD).withOpacity(0.25),
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
                            color: Colors.black87,
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
        const SizedBox(height: 5),
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
                Obx(() {
                  final kunyomi = controller.kunyomi.value;
                  final parts = kunyomi.split('/');

                  final firstPart = parts.isNotEmpty ? parts.first : '';
                  final secondPart = parts.length > 1
                      ? kunyomi.substring(kunyomi.indexOf('/'))
                      : '';

                  return PronunciationButton(
                    color: const Color(0xFFF6F585),
                    onTap: () => controller.playAudio('kunyomi'),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: firstPart,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: secondPart,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                const Text("On'yomi"),
                const SizedBox(height: 5),
                Obx(() {
                  final onyomi = controller.onyomi.value;
                  final parts = onyomi.split('/');

                  final firstPart = parts.isNotEmpty ? parts.first : '';
                  final secondPart = parts.length > 1
                      ? onyomi.substring(onyomi.indexOf('/'))
                      : '';

                  return PronunciationButton(
                    color: const Color(0xFFF6F585),
                    onTap: () => controller.playAudio('kunyomi'),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: firstPart,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: secondPart,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFC4E0FD).withOpacity(0.25),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            controller.displayVisibility.value
                ? "あの山は高いです。"
                : controller.cardVisibility.value
                ? controller.isAnsSelected.value
                      ? controller.isAnswered.value
                            ? "Correct! 🎉"
                            : "Incorrect. Try again!"
                      : "Select the correct meaning"
                : "Contratulations! 🎉",

            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[400],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Card(
      color: const Color(0xFFF6F585),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
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
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 225, 239, 253)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${String.fromCharCode(97 + index)})",
                    style: TextStyle(
                      color: Colors.black.withOpacity(1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${controller.options[index]}",
                    style: TextStyle(
                      color: Color(0xFF1D2126).withOpacity(0.6),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
    return Image.asset(
      controller.isAnswered.value ? "assets/right.png" : "assets/wrong.png",
      height: 24,
      width: 24,
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
  final String? pronunciation;
  final Widget? child;
  final Color color;
  final VoidCallback onTap;

  const PronunciationButton({
    super.key,
    this.pronunciation,
    this.child,
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:
                  child ??
                  Text(
                    pronunciation ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
            ),
            SizedBox(width: 8),
            Image.asset("assets/mike.png", height: 24, width: 24),
          ],
        ),
      ),
    );
  }
}
