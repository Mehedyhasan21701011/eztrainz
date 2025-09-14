import 'package:eztrainz/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            "assets/logo2.png",
            height: 36,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.apps, size: 36, color: Colors.blue);
            },
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
                radius: 18,
                backgroundColor: Colors.blue[50],
                child: const Icon(Icons.person, size: 24, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildPlayGamesSection(),
            const SizedBox(height: 30),
            _buildLessonsHeader(),
            const SizedBox(height: 16),
            Expanded(child: _buildLessonsList()),
            const SizedBox(height: 16),
            _buildLevelSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayGamesSection() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Play Games",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2B2B),
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/champion.png",
              width: 30,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.emoji_events,
                  size: 30,
                  color: Colors.amber,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to games page
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.blue[50],
              child: Image.asset(
                "assets/playcard.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade100, Colors.blue.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.games, size: 40, color: Colors.blue),
                          SizedBox(height: 8),
                          Text(
                            "Play Learning Games",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonsHeader() {
    return Row(
      children: [
        const Text(
          "Lessons",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2B2B2B),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE1EFFD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search lessons...",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelSelector() {
    return Obx(() {
      return Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.yellow,
            border: Border.all(color: Colors.amber.shade300, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: ["N1", "N2", "N3"].map((level) {
                final isSelected = controller.selectedLevel.value == level;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeLevel(level),
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          level,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.blue[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLessonsList() {
    return Obx(() {
      final lessons = controller.lessons;

      if (lessons.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.book_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "No lessons available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          final progress = controller.getProgressForLesson(index);
          final isExpanded = controller.expandedIndex.value == index;

          final bool isUnlocked =
              index == 0 || controller.getProgressForLesson(index - 1) == 1.0;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE1EFFD),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IgnorePointer(
              ignoring: !isUnlocked,
              child: Opacity(
                opacity: isUnlocked ? 1.0 : 0.5,
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    // Remove initiallyExpanded and key
                    maintainState: true,
                    onExpansionChanged: (expanded) {
                      if (expanded) {
                        controller.toggleExpand(index);
                      } else {
                        controller.toggleExpand(null);
                      }
                    },
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isUnlocked
                                  ? const Color(0xFF2B2B2B)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.blue.shade100,
                                valueColor: const AlwaysStoppedAnimation(
                                  Colors.blue,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${(progress * 100).toInt()}%",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: isUnlocked
                        ? AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(
                              Icons.expand_more,
                              color: Colors.blue,
                            ),
                          )
                        : const Icon(Icons.lock, color: Colors.grey),
                    children: (lesson["videos"] as List).asMap().entries.map((
                      entry,
                    ) {
                      final videoIndex = entry.key;
                      final video = entry.value;
                      final watched = video["watched"] as bool;

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 4,
                        ),
                        leading: Container(
                          width: 50,
                          height: 48,
                          decoration: BoxDecoration(
                            color: watched ? Colors.green : Colors.yellow,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            watched ? Icons.check : Icons.play_arrow,
                            size: 20,
                            color: watched
                                ? Colors.white
                                : Colors.grey.shade800,
                          ),
                        ),
                        title: Text(
                          "Video ${videoIndex + 1}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: watched
                                ? Colors.green.shade700
                                : const Color(0xFF2B2B2B),
                            decoration: watched
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          video["url"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          controller.markVideoWatched(index, videoIndex);
                          controller.playVideo(video["url"]);
                        },
                        trailing: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              strokeWidth: 3,
                              backgroundColor: Colors.yellow,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "${(progress * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
