import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/list_content_controller.dart';

class ListContentView extends GetView<ListContentController> {
  const ListContentView({super.key});
  @override
  Widget build(BuildContext context) {
    final contentItem = Get.arguments as Map<String, dynamic>;

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
      body: Column(
        children: [
          _buildVideoSection(),
          SizedBox(height: 20),
          _buildTitleSection(),
          SizedBox(height: 20),
          _buildOptionSection(),
          SizedBox(height: 20),
          _buildDisplaySection(),
          // _buildCardSection(),
          // _buildCongratulationSection(),
          SizedBox(height: 20),
          _buildBottomMessage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
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
            // TODO: Navigate to Profile page
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 238, 244, 250),
              radius: 20,
              child: const Icon(Icons.person, size: 30, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 249, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          YoutubePlayer(
            controller: controller.ytController,
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Text(
              controller.lessonTitle.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(221, 32, 31, 31),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.kanjiOptions
            .map(
              (kanji) => _buildOptionButton(
                kanji: kanji,
                isSelected:
                    kanji ==
                    controller.kanjiOptions[0], // First one selected by default
                onTap: () => controller.selectKanjiOption(kanji),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Column(
      children: [
        Obx(
          () => Text(
            controller.currentKanji.value,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.blue.withOpacity(0.8),
            ),
          ),
        ),
        Obx(
          () => Text(
            controller.kanjiMeaning.value,
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(221, 32, 31, 31),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildPronunciationSection(),
      ],
    );
  }

  Widget _buildPronunciationSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Kun\'yomi"),
                SizedBox(height: 5),
                PronunciationButton(
                  pronunciation: controller.kunyomi.value,
                  color: Colors.yellow[300]!,
                  onTap: () => controller.playAudio('kunyomi'),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text("On\'yomi"),
                SizedBox(height: 5),
                PronunciationButton(
                  pronunciation: controller.onyomi.value,
                  color: Colors.yellow[300]!,
                  onTap: () => controller.playAudio('onyomi'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMessage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 249, 255),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'あのひとは高いです。',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue[400],
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
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
              return Obx(() {
                bool isSelected = controller.selectedOption.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.selectedOption.value = index;
                    if (controller.options[index] == controller.answer) {
                      controller.isAnswered.value = true;
                    } else {
                      controller.isAnswered.value = false;
                    }
                  },
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
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Icon(
                          isSelected
                              ? (controller.isAnswered.value
                                    ? Icons.check_circle
                                    : Icons.cancel)
                              : Icons.cancel,
                          color: isSelected
                              ? (controller.isAnswered.value
                                    ? Colors.green
                                    : Colors.red)
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                );
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCongratulationSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/congratulations.png", width: 150, height: 150),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _buildOptionButton extends StatefulWidget {
  final String kanji;
  final bool isSelected;
  final VoidCallback onTap;

  const _buildOptionButton({
    Key? key,
    required this.kanji,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_buildOptionButton> createState() => _KanjiOptionButtonState();
}

class _KanjiOptionButtonState extends State<_buildOptionButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? Colors.yellow[300]
                      : _isHovered
                      ? Color.fromARGB(255, 244, 249, 255)
                      : Color.fromARGB(255, 244, 249, 255),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isHovered || widget.isSelected
                      ? [
                          BoxShadow(
                            color: widget.isSelected
                                ? Colors.orange.withOpacity(0.3)
                                : Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    widget.kanji,
                    style: TextStyle(
                      fontSize: _isHovered ? 26 : 24,
                      fontWeight: FontWeight.bold,
                      color: _isHovered ? Colors.blue[700] : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PronunciationButton extends StatelessWidget {
  final String pronunciation;
  final Color color;
  final VoidCallback onTap;

  const PronunciationButton({
    Key? key,
    required this.pronunciation,
    required this.color,
    required this.onTap,
  }) : super(key: key);

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
