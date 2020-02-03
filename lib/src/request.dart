import 'dart:async';
import 'package:http/http.dart' as http;

class ColorProvider {
  var client = new http.Client();
  Future<void> colorPuro(red, green, blue) async {
    await client.get(
        'http://192.168.1.200/colorPuro?red=$red&blue=$blue&green=$green&estado=0');
    await client.get(
        'http://192.168.1.200/colorPuro?red=$red&blue=$blue&green=$green&estado=0');
  }

  Future<void> cambiarModo(estado) async {
    await client.get('http://192.168.1.200/state?estado=$estado');
  }
}

final colorProvider = new ColorProvider();
