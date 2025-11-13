import 'package:eztrainz/app/service/translatorcontroller.dart';
import 'package:eztrainz/app/utils/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  Set global status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // Initialize ThemeService and LanguageController
  await Get.putAsync(() async => ThemeService());
  final langCtrl = Get.put(LanguageController()); // Global translator

  runApp(MyApp(langCtrl: langCtrl));
}

class MyApp extends StatelessWidget {
  final LanguageController langCtrl;
  const MyApp({super.key, required this.langCtrl});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "EZTrainz",
        theme: ThemeData(fontFamily: 'Poppins'),
        darkTheme: themeService.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        // Reactive locale using Obx
        locale: Locale(langCtrl.currentLang.value, ''),
        fallbackLocale: const Locale('en', 'US'),
      ),
    );
  }
}
