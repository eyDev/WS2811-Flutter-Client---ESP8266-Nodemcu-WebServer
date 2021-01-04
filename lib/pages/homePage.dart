import 'package:flutter/material.dart';
import 'package:leds/models/luzModel.dart';
import 'package:leds/pages/settingsPage.dart';
import 'package:leds/widgets/dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Luz> luces = <Luz>[
    Luz(name: 'Rainbow', description: 'styleRainbow'.tr()),
    Luz(name: 'Color Puro', description: 'styleColorPure'.tr(), colorPicker: true),
    Luz(name: 'Fade', description: 'styleFade'.tr()),
    Luz(name: 'Color Wipe', description: 'styleColorWipe'.tr()),
    Luz(name: 'Fire', description: 'styleFire'.tr(), colorPicker: true),
    Luz(name: 'Side Fill', description: 'styleSideFill'.tr(), colorPicker: true),
    Luz(name: 'Xmas', description: 'styleXmas'.tr()),
    Luz(name: 'Modo Oculto', description: 'styleModoOculto'.tr()),
  ];

  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('ledLights'.tr()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => DialogWidget(
                luzEffect: Luz(name: "TurnOff"),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _optionsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        ),
        child: Icon(Icons.settings),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _optionsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 2,
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (_) => DialogWidget(
                  luzEffect: luces[index],
                ),
              ),
              leading: Icon(Icons.color_lens_outlined),
              title: Text('${luces[index].name}'),
              subtitle: Text('${luces[index].description}'),
            ),
          );
        },
        childCount: luces.length,
      ),
    );
  }
}
