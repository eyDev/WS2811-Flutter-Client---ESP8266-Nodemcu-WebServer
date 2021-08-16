import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._();
  factory UserPreferences() {
    return _instancia;
  }
  UserPreferences._();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get ipAddress {
    return _prefs!.getString('ipAddress') ?? '192.168.1.200';
  }

  set ipAddress(String value) {
    _prefs!.setString('ipAddress', value);
  }

  Color get primaryColor {
    return Color.fromRGBO(_prefs!.getInt('red') ?? 0, _prefs!.getInt('green') ?? 0, _prefs!.getInt('blue') ?? 0, 1.0);
  }

  set primaryColor(Color value) {
    _prefs!.setInt('red', value.red);
    _prefs!.setInt('green', value.green);
    _prefs!.setInt('blue', value.blue);
  }

  bool get darkMode {
    return _prefs!.getBool('darkMode') ?? false;
  }

  set darkMode(bool value) {
    _prefs!.setBool('darkMode', value);
  }

  String get language {
    String sl = ui.window.locale.languageCode;
    if (sl != 'en' && sl != 'es') {
      sl = 'en';
    }
    return _prefs!.getString('language') ?? sl;
  }

  set language(String value) {
    _prefs!.setString('language', value);
  }
}
