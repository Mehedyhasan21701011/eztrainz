import 'package:eztrainz/app/service/traslatorservice.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var currentLang = 'en'.obs;

  void changeLanguage(String langCode) {
    currentLang.value = langCode;
  }

  // Translate text dynamically using Google API
  Future<String> translateText(String text) async {
    if (currentLang.value == 'en') return text; // default English
    return await GoogleTranslateService.translate(text, currentLang.value);
  }
}
