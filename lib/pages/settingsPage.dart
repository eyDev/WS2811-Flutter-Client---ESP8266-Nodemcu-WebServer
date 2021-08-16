import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:leds_remasterized/models/streamValidator.dart';
import 'package:leds_remasterized/prefs/preferences.dart';
import 'package:leds_remasterized/provider/themeChanger.dart';
import 'package:leds_remasterized/widgets/customTextField.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserPreferences _prefs = new UserPreferences();
  late Color _primaryColor;
  late bool _darkMode;

  @override
  void initState() {
    super.initState();
    _primaryColor = _prefs.primaryColor;
    _darkMode = _prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        backgroundColor: primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          _optionsList(theme),
        ],
      ),
    );
  }

  Widget _optionsList(ThemeChanger theme) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _optionItem(
            'changeIP'.tr(),
            'changeIPdescription'.tr(),
            Icons.speaker_phone_sharp,
            () => _changeIp(),
          ),
          _optionItem(
            'changePrimaryColor'.tr(),
            'changePrimaryColordescription'.tr(),
            Icons.color_lens,
            () => colorPicker(context, theme),
          ),
          _optionItem(
            'changeLanguage'.tr(),
            'changeLanguagedescription'.tr(),
            Icons.language,
            () => _languageDialog(),
          ),
          _optionDarkTheme(theme),
          _logo(),
        ],
      ),
    );
  }

  Widget _optionItem(String titulo, String subtitulo, IconData icono, funcion) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 2,
      child: ListTile(
        onTap: funcion,
        trailing: Icon(icono),
        title: Text(titulo),
        subtitle: Text(subtitulo),
      ),
    );
  }

  Widget _optionDarkTheme(ThemeChanger theme) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 2,
      child: SwitchListTile(
        value: _darkMode,
        onChanged: (value) {
          setState(() {
            changeTheme(value, _primaryColor, theme);
          });
        },
        title: Text('changeDarkMode'.tr()),
        subtitle: Text('changeDarkModedescription'.tr()),
        activeColor: /* _primaryColor */ Colors.black,
      ),
    );
  }

  void _changeIp() {
    final bloc = Provider.of<IPaddressBloc>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('enterIP'.tr()),
          content: Column(
            children: [
              CustomInputField(
                label: _prefs.ipAddress,
                prefixIcon: Icons.lock,
                tstream: bloc.ipStream,
                tonChanged: bloc.changeip,
                type: TextInputType.text,
              ),
              SizedBox(height: 10),
              StreamBuilder(
                stream: bloc.ipStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(_primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        )),
                      ),
                      child: Text('change'.tr(), style: TextStyle(color: Colors.white)),
                      onPressed: snapshot.hasData
                          ? () {
                              _prefs.ipAddress = snapshot.data;
                              Navigator.pop(context);
                            }
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeColor(Color color) {
    setState(() {
      _primaryColor = color;
      _prefs.primaryColor = color;
    });
  }

  void colorPicker(BuildContext context, theme) {
    var colorpicker = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _primaryColor,
          onColorChanged: _changeColor,
          showLabel: false,
          pickerAreaHeightPercent: 0.8,
          enableAlpha: false,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('cancell'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('change'.tr()),
          onPressed: () {
            setState(() {
              changeTheme(_darkMode, _primaryColor, theme);
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => colorpicker);
  }

  void _languageDialog() {
    Widget englishOption = SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('english'.tr()),
          Image(
            image: AssetImage('assets/flags/usa.png'),
            height: 20.0,
          ),
        ],
      ),
      onPressed: () {
        _cambiarIdioma('en');
        Navigator.of(context).pop();
      },
    );
    Widget spanishOption = SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('spanish'.tr()),
          Image(
            image: AssetImage('assets/flags/spain.png'),
            height: 20.0,
          ),
        ],
      ),
      onPressed: () {
        _cambiarIdioma('es');
        Navigator.of(context).pop();
      },
    );
    SimpleDialog dialog = SimpleDialog(
      title: Text('chooseLanguage'.tr()),
      children: <Widget>[
        englishOption,
        spanishOption,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void _cambiarIdioma(String code) {
    context.setLocale(Locale(code));
    _prefs.language = code;
  }

  void changeTheme(bool darkMode, Color primaryColor, ThemeChanger theme) {
    _darkMode = darkMode;
    _primaryColor = primaryColor;
    _prefs.primaryColor = primaryColor;
    _prefs.darkMode = darkMode;
    theme.setTheme(
      ThemeData(
        brightness: _prefs.darkMode ? Brightness.dark : Brightness.light,
        primaryColor: _prefs.primaryColor,
      ),
    );
  }

  Widget _logo() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50,
      child: Image(image: AssetImage('assets/images/logo.png')),
    );
  }
}
