import 'package:eztrainz/app/utils/constraint/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Set global status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Black background
      statusBarIconBrightness: Brightness.light, // White icons (Android)
      statusBarBrightness: Brightness.dark, // White icons (iOS)
    ),
  );

  // ✅ Initialize ThemeService with GetX
  await Get.putAsync(() async => ThemeService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EZTrainz",
      theme: themeService.lightTheme,
      darkTheme: themeService.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.INITIAL, // ✅ SplashScreen first
      getPages: AppPages.routes,
    );
  }
}
