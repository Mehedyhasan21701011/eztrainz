import 'package:eztrainz/app/modules/home/controllers/home_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
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
      appBar: _buildAppBar(),
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
              backgroundColor: const Color.fromARGB(255, 238, 244, 250),
              radius: 20,
              child: const Icon(Icons.person, size: 30, color: Colors.blue),
            ),
          ),
        ),
      ],
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
                Icon(Icons.search, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search lessons...",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.blue),
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
          width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.yellow[300]!,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: ["N1", "N2", "N3"].map((level) {
                final isSelected = controller.selectedLevel.value == level;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeLevel(level),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
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

  Widget _buildEmptyState() {
    return const Center(
      key: ValueKey('empty-lessons'),
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

  Widget _buildLessonsListView(List lessons) {
    return ListView.builder(
      key: ValueKey('lessons-${controller.selectedLevel.value}'),
      itemCount: lessons.length,
      itemBuilder: (context, index) => _buildLessonItem(lessons, index),
    );
  }

  Widget _buildLessonItem(List lessons, int index) {
    final lesson = lessons[index];
    final lessonId = lesson["id"] ?? index;

    return GetBuilder<HomeController>(
      id: 'lesson-$index', // Use GetBuilder for more control
      builder: (controller) {
        final progress = controller.getProgressForLesson(index) ?? 0.0;
        final isExpanded = controller.expandedIndex.value == index;
        final isUnlocked =
            index == 0 ||
            (controller.getProgressForLesson(index - 1) ?? 0.0) == 1.0;
        final content = (lesson["content"] as List?) ?? [];

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
                  Get.context!,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: PageStorageKey(
                    'expansion-${controller.selectedLevel.value}-$lessonId',
                  ),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    // Defer the state update to avoid setState during build
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.toggleExpand(expanded ? index : null);
                    });
                  },
                  title: _buildLessonTitle(lesson, index, isUnlocked),
                  subtitle: _buildLessonProgress(progress),
                  trailing: Icon(
                    isUnlocked ? Icons.lock_open : Icons.lock,
                    color: isUnlocked ? Colors.blue : Colors.grey,
                  ),
                  children: _buildLessonContent(content, progress),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLessonTitle(Map lesson, int index, bool isUnlocked) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text("Unit ${index + 1}"),
              Text(
                lesson["title"] ?? "Untitled",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isUnlocked ? const Color(0xFF2B2B2B) : Colors.grey,
                ),
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
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.yellow[300]!,

                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: progress > 0 ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLessonContent(List content, double progress) {
    return content.asMap().entries.map((entry) {
      final contentIndex = entry.key;
      final contentItem = entry.value;
      final watched = contentItem["watched"] as bool? ?? false;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: watched ? Colors.green : Colors.yellow[300]!,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                watched ? Icons.check : Icons.play_arrow,
                size: 30,
                color: watched ? Colors.white : Colors.blue,
              ),
            ),
            title: Text(
              contentItem["title"] ?? "Untitled",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: watched
                    ? Colors.green.shade700
                    : const Color(0xFF2B2B2B),
              ),
            ),
            trailing: _buildContentProgress(progress),
            onTap: () {
              Get.toNamed(Routes.LIST_CONTENT, arguments: contentItem);
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
          strokeWidth: 6,
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
