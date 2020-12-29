import 'package:flutter/material.dart';
import 'package:leds/models/luzModel.dart';
import 'package:leds/widgets/dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Luz> luces = <Luz>[
    Luz(name: 'Rainbow', description: 'Efecto estilo arcoiris.'),
    Luz(
        name: 'Color Puro',
        description: 'Cambia a un determinado color.',
        colorPicker: true),
    Luz(name: 'Fade', description: 'Desvanece los colores progresivamente.'),
    Luz(name: 'Color Wipe', description: 'Rellena la tira de colores.'),
    Luz(
        name: 'Fire',
        description: 'Efecto de llama de fuego.',
        colorPicker: true),
    Luz(
        name: 'Side Fill',
        description: 'Rellena la tira de un solo color.',
        colorPicker: true),
    Luz(name: 'Xmas', description: 'Efecto estilo navidad.'),
    Luz(name: 'Modo Oculto', description: 'Modo secreto :v'),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Luces led'),
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
