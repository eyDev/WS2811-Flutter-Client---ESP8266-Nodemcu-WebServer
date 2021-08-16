import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:leds_remasterized/prefs/preferences.dart';

class ServerProvider {
  final UserPreferences prefs = UserPreferences();

  Future<String> changeState(Map<String, String> queryParameter) async {
    final String _url = prefs.ipAddress;
    final url = Uri.http(_url, '/luces', queryParameter);
    try {
      final response = await http.post(url).timeout(const Duration(seconds: 5));
      return response.statusCode == 200 ? 'Changed' : 'Error';
    } on TimeoutException {
      return 'Error';
    } on Error {
      return 'Error';
    }
  }
}
