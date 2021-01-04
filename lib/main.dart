import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leds/models/streamValidator.dart';
import 'package:leds/pages/homePage.dart';
import 'package:leds/prefs/preferences.dart';
import 'package:leds/provider/themeChanger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserPreferences prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('en'),
      Locale('es'),
    ],
    useOnlyLangCode: true,
    path: 'assets/langs',
  ));
}

class MyApp extends StatelessWidget {
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => IPaddressBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeChanger(
            ThemeData(
              brightness: prefs.darkMode ? Brightness.dark : Brightness.light,
              primaryColor: prefs.primaryColor,
            ),
          ),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LED LIGHTS',
      home: HomePage(),
      builder: EasyLoading.init(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: Locale(prefs.language), //EasyLocalization.of(context).locale,
      theme: theme.getTheme(),
    );
  }
}
