import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleTranslateService {
  static const _apiKey = 'AIzaSyC5HI7xdvHYqORdd0CAgRmXiqn8K9Oy7s4';
  static const _baseUrl =
      'https://translation.googleapis.com/language/translate/v2';

  static Future<String> translate(String text, String targetLang) async {
    final response = await http.post(
      Uri.parse('$_baseUrl?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'q': text, 'target': targetLang}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate: ${response.body}');
    }
  }
}
