import 'package:get/get.dart';

import '../modules/adjective/bindings/adjective_binding.dart';
import '../modules/adjective/views/adjective_view.dart';
import '../modules/adverb/bindings/adverb_binding.dart';
import '../modules/adverb/views/adverb_view.dart';
import '../modules/courseoverview/bindings/courseoverview_binding.dart';
import '../modules/courseoverview/views/courseoverview_view.dart';
import '../modules/gamepage/bindings/gamepage_binding.dart';
import '../modules/gamepage/views/gamepage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/learngrammer/bindings/learngrammer_binding.dart';
import '../modules/learngrammer/views/learngrammer_view.dart';
import '../modules/listContent/bindings/list_content_binding.dart';
import '../modules/listContent/views/list_content_view.dart';
import '../modules/nounpronoun/bindings/nounpronoun_binding.dart';
import '../modules/nounpronoun/views/nounpronoun_view.dart';
import '../modules/onboardingscreen/bindings/onboardingscreen_binding.dart';
import '../modules/onboardingscreen/views/onboardingscreen_view.dart';
import '../modules/pamentsuccess/bindings/pamentsuccess_binding.dart';
import '../modules/pamentsuccess/views/pamentsuccess_view.dart';
import '../modules/particledetails/bindings/particledetails_binding.dart';
import '../modules/particledetails/views/particledetails_view.dart';
import '../modules/particlepage/bindings/particlepage_binding.dart';
import '../modules/particlepage/views/particlepage_view.dart';
import '../modules/practicegrammer/bindings/practicegrammer_binding.dart';
import '../modules/practicegrammer/views/practicegrammer_view.dart';
import '../modules/profilepage/bindings/profilepage_binding.dart';
import '../modules/profilepage/views/profilepage_view.dart';
import '../modules/purchasedetails/bindings/purchasedetails_binding.dart';
import '../modules/purchasedetails/views/purchasedetails_view.dart';
import '../modules/registerpage/bindings/registerpage_binding.dart';
import '../modules/registerpage/views/registerpage_view.dart';
import '../modules/secondonboardingpage/bindings/secondonboardingpage_binding.dart';
import '../modules/secondonboardingpage/views/secondonboardingpage_view.dart';
import '../modules/sentence/bindings/sentence_binding.dart';
import '../modules/sentence/views/sentence_view.dart';
import '../modules/sentencexample/bindings/sentencexample_binding.dart';
import '../modules/sentencexample/views/sentencexample_view.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/splashscreen/controllers/splash_screen_controller.dart';
import '../modules/thirdonboardingpage/bindings/thirdonboardingpage_binding.dart';
import '../modules/thirdonboardingpage/views/thirdonboardingpage_view.dart';
import '../modules/verbdetails/bindings/verbdetails_binding.dart';
import '../modules/verbdetails/views/verbdetails_view.dart';
import '../modules/vocabolarygrammer/bindings/vocabolarygrammer_binding.dart';
import '../modules/vocabolarygrammer/views/vocabolarygrammer_view.dart';
import '../modules/wordpage/bindings/wordpage_binding.dart';
import '../modules/wordpage/views/wordpage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
    GetPage(
      name: _Paths.REGISTERPAGE,
      page: () => const RegistrationView(),
      binding: RegisterpageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILEPAGE,
      page: () => const ProfileView(),
      binding: ProfilepageBinding(),
    ),
    GetPage(
      name: _Paths.PARTICLEPAGE,
      page: () => const ParticlesView(),
      binding: ParticlepageBinding(),
    ),
    GetPage(
      name: _Paths.COURSEOVERVIEW,
      page: () => const CourseoverviewView(),
      binding: CourseoverviewBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASEDETAILS,
      page: () => const PurchasedetailsView(),
      binding: PurchasedetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAMENTSUCCESS,
      page: () => const PamentsuccessView(),
      binding: PamentsuccessBinding(),
    ),
    GetPage(
      name: _Paths.PARTICLEDETAILS,
      page: () => const ParticledetailsView(),
      binding: ParticledetailsBinding(),
    ),
    GetPage(
      name: _Paths.VERBDETAILS,
      page: () => const VerbdetailsView(),
      binding: VerbdetailsBinding(),
    ),
    GetPage(
      name: _Paths.SENTENCE,
      page: () => const SentenceView(),
      binding: SentenceBinding(),
    ),
    GetPage(
      name: _Paths.SENTENCEXAMPLE,
      page: () => const SentencexampleView(),
      binding: SentencexampleBinding(),
    ),
    GetPage(
      name: _Paths.NOUNPRONOUN,
      page: () => const NounpronounView(),
      binding: NounpronounBinding(),
    ),
    GetPage(
      name: _Paths.ADJECTIVE,
      page: () => const AdjectiveView(),
      binding: AdjectiveBinding(),
    ),
    GetPage(
      name: _Paths.ADVERB,
      page: () => const AdverbView(),
      binding: AdverbBinding(),
    ),
  ];
}
