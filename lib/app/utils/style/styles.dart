import 'package:flutter/material.dart';

/// 🎨 App Colors
class AppColors {
  static const Color primary = Color(0xFF3193F5);
  static const Color buttonSecondary = Color(0xFFFFFC00);
  static const Color background = Color(0xFFF5F5F5);
  static const Color buttonBackground = Color(0xFFE1EFFD);
  static const Color cardBackground = Color(0xFFE1EFFD);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color secondaryButton = Color(0xFFE1EFFD);

  static const titleStyle = TextStyle(fontSize: 16, color: Colors.black87);
  static const highlightStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
}

/// 📝 App Text Styles
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );

  static const TextStyle caption = TextStyle(fontSize: 12, color: Colors.grey);
}

/// 📏 App Spacing (Optional)
class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

class Heading {
  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    color: Color.fromARGB(190, 0, 0, 0),
    fontWeight: FontWeight.bold,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    color: Color(0xD90E0E0E),
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
  );
  static const TextStyle heading1 = TextStyle(
    fontSize: 16,
    color: Color(0xD90E0E0E),
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.0,
  );
}
