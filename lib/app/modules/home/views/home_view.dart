import 'package:eztrainz/app/modules/home/controllers/home_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/style/styles.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/search.dart';
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
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/logo2.png",
        rightIconPath: "assets/profile.png",
        onRightIconTap: () {
          Get.toNamed(Routes.PROFILEPAGE);
        },
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
            Expanded(child: _buildOptimizedLessonsList()),
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
            const Text("Play Games", style: Heading.heading3),
            const Spacer(),
            Image.asset(
              "assets/madel.png",
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
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.GAMEPAGE);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                  child: Center(
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
      ],
    );
  }

  Widget _buildLessonsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Title
          const Text("Lessons", style: Heading.heading3),
          const SizedBox(width: 80),

          /// Search Bar
          buildSearch(),
        ],
      ),
    );
  }

  Widget _buildLevelSelector() {
    return Obx(() {
      return Center(
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFFFC00),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: ["N5", "N4", "N3"].map((level) {
                // Safe access with null check
                final selectedLevel = controller.selectedLevel.value;
                final isSelected = selectedLevel == level;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeLevel(level),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 45,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3193F5)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.blue[700],
                          ),
                          child: Text(level),
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

  Widget _buildOptimizedLessonsList() {
    return Obx(() {
      final lessons = controller.lessons;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1, 0), // slide from right
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: lessons.isEmpty
            ? _buildEmptyState()
            : _buildLessonsListView(lessons),
      );
    });
  }

  Widget _buildEmptyState([String message = "No lessons available"]) {
    return Center(
      key: const ValueKey('empty-lessons'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.book_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsListView(List lessons) {
    final selectedLevel = controller.selectedLevel.value;

    return ListView.builder(
      key: ValueKey('lessons-$selectedLevel'),
      itemCount: lessons.length,
      itemBuilder: (context, index) => _buildLessonItem(lessons, index),
    );
  }

  Widget _buildLessonItem(List lessons, int index) {
    final lesson = lessons[index] as Map<String, dynamic>;
    final lessonId = lesson["id"] ?? index;

    return GetBuilder<HomeController>(
      id: 'lesson-$index', // Use GetBuilder for more control
      builder: (controller) {
        final progress = controller.getProgressForLesson(index);
        final isExpanded = controller.expandedIndex.value == index;
        final isUnlocked =
            index == 0 || (controller.getProgressForLesson(index - 1)) == 1.0;
        final content = (lesson["content"] as List?) ?? [];

        return Builder(
          builder: (builderContext) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE1EFFD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IgnorePointer(
                ignoring: !isUnlocked,
                child: Opacity(
                  opacity: 1,
                  child: Theme(
                    data: Theme.of(
                      builderContext,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: PageStorageKey(
                        'expansion-${controller.selectedLevel.value}-$lessonId',
                      ),
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.toggleExpand(expanded ? index : null);
                        });
                      },
                      title: _buildLessonTitle(lesson, index, isUnlocked),
                      subtitle: _buildLessonProgress(
                        progress,
                      ), // ✅ Updated progress
                      trailing: Image.asset(
                        isUnlocked ? "assets/unlock.png" : "assets/lock.png",
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            isUnlocked ? Icons.lock_open : Icons.lock,
                            size: 24,
                          );
                        },
                      ),
                      children: _buildLessonContent(
                        content,
                        progress,
                      ), // ✅ Updated progress
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLessonTitle(Map lesson, int index, bool isUnlocked) {
    final String title = lesson["title"] ?? "Untitled";

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                "Unit ${index + 1}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: isUnlocked
                      ? const Color.fromARGB(255, 0, 0, 0).withOpacity(
                          0.8,
                        ) // Darker text if unlocked
                      : const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withOpacity(0.6), // Muted text if locked
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Prevents text overflow
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLessonProgress(double progress) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          SizedBox(
            height: 12,
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
                value: progress.clamp(0.0, 1.0),
                backgroundColor: const Color(0xFFFFFC00),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF3193F5)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: progress > 0 ? const Color(0xFF3193F5) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLessonContent(List content, double progress) {
    return content.asMap().entries.map((entry) {
      final contentItem = entry.value;
      final watched = contentItem["watched"] as bool? ?? false;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  134,
                  133,
                  133,
                ).withOpacity(0.1),
                offset: const Offset(3, 3),
                blurRadius: 2,
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: watched ? Colors.green : Color(0xFFF6F585),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                watched ? Icons.check : Icons.play_arrow,
                size: 30,
                color: watched ? Colors.white : Color(0xFF3193F5),
              ),
            ),
            title: Text(
              contentItem["title"] ?? "Untitled",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: watched
                    ? Colors.green.shade700
                    : const Color.fromARGB(255, 74, 73, 73),
              ),
            ),
            trailing: _buildContentProgress(0.4),
            onTap: () {
              final title = contentItem["title"];

              if (title == "Kanji") {
                Get.toNamed(Routes.LIST_CONTENT, arguments: contentItem);
              } else if (title == "Vocabulary & Grammar") {
                Get.toNamed(Routes.VOCABOLARYGRAMMER);
              } else {
                // Do nothing or show a message
              }
            },
          ),
        ),
      );
    }).toList();
  }

  Widget _buildContentProgress(double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          strokeWidth: 3,
          backgroundColor: Colors.yellow[300]!,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
