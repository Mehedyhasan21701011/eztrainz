class GameModel {
  final String title;
  final String subtitle;
  final double progress;
  final bool isLocked;

  GameModel({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isLocked,
  });

  // Factory constructor to create from JSON map
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      title: json['title'],
      subtitle: json['subtitle'],
      progress: json['progress'],
      isLocked: json['isLocked'],
    );
  }
}
