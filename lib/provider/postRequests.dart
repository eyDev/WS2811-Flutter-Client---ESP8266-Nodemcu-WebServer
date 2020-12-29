import 'dart:async';
import 'package:http/http.dart' as http;

class ServerProvider {
  final String _url = '192.168.1.200';

  Future<String> changeState(Map<String, String> queryParameter) async {
    final url = Uri.http(_url, '/luces', queryParameter);
    print(url);
    try {
      final response = await http.post(url);
      return response.statusCode == 200 ? 'Changed' : 'Error';
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}
