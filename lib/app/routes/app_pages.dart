import 'package:get/get.dart';

import '../modules/gamepage/bindings/gamepage_binding.dart';
import '../modules/gamepage/views/gamepage_view.dart';
import '../modules/grammerpage/bindings/grammerpage_binding.dart';
import '../modules/grammerpage/views/grammerpage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/learngrammer/bindings/learngrammer_binding.dart';
import '../modules/learngrammer/views/learngrammer_view.dart';
import '../modules/listContent/bindings/list_content_binding.dart';
import '../modules/listContent/views/list_content_view.dart';
import '../modules/onboardingscreen/bindings/onboardingscreen_binding.dart';
import '../modules/onboardingscreen/views/onboardingscreen_view.dart';
import '../modules/practicegrammer/bindings/practicegrammer_binding.dart';
import '../modules/practicegrammer/views/practicegrammer_view.dart';
import '../modules/secondonboardingpage/bindings/secondonboardingpage_binding.dart';
import '../modules/secondonboardingpage/views/secondonboardingpage_view.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/splashscreen/controllers/splash_screen_controller.dart';
import '../modules/thirdonboardingpage/bindings/thirdonboardingpage_binding.dart';
import '../modules/thirdonboardingpage/views/thirdonboardingpage_view.dart';
import '../modules/vocabolarygrammer/bindings/vocabolarygrammer_binding.dart';
import '../modules/vocabolarygrammer/views/vocabolarygrammer_view.dart';
import '../modules/wordpage/bindings/wordpage_binding.dart';
import '../modules/wordpage/views/wordpage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: BindingsBuilder(() {
        Get.put(SplashScreenController()); // ✅ Register controller here
      }),
    ),
    GetPage(
      name: _Paths.ONBOARDINGSCREEN,
      page: () => const OnboardingscreenView(),
      binding: OnboardingscreenBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CONTENT,
      page: () => const ListContentView(),
      binding: ListContentBinding(),
    ),
    GetPage(
      name: _Paths.VOCABOLARYGRAMMER,
      page: () => const VocabolaryView(),
      binding: VocabolarygrammerBinding(),
    ),
    GetPage(
      name: _Paths.WORDPAGE,
      page: () => WordpageView(),
      binding: WordpageBinding(),
    ),
    GetPage(
      name: _Paths.GAMEPAGE,
      page: () => const GamepageView(),
      binding: GamepageBinding(),
    ),
    GetPage(
      name: _Paths.GRAMMERPAGE,
      page: () => const GrammerpageView(),
      binding: GrammerpageBinding(),
    ),
    GetPage(
      name: _Paths.LEARNGRAMMER,
      page: () => const LearngrammerView(),
      binding: LearngrammerBinding(),
    ),
    GetPage(
      name: _Paths.PRACTICEGRAMMER,
      page: () => const PracticegrammerView(),
      binding: PracticegrammerBinding(),
    ),
    GetPage(
      name: _Paths.SECONDONBOARDINGPAGE,
      page: () => const SecondonboardingpageView(),
      binding: SecondonboardingpageBinding(),
    ),
    GetPage(
      name: _Paths.THIRDONBOARDINGPAGE,
      page: () => const ThirdonboardingpageView(),
      binding: ThirdonboardingpageBinding(),
    ),
  ];
}
