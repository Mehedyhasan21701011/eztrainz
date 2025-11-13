import 'package:eztrainz/app/service/translatorcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final langCtrl = Get.find<LanguageController>();

    return Obx(() => FutureBuilder<String>(
          future: langCtrl.translateText(text),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text(text, style: style, textAlign: textAlign);
            return Text(snapshot.data!, style: style, textAlign: textAlign);
          },
        ));
  }
}
