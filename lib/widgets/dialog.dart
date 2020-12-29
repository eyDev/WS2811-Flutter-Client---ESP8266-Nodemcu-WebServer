import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:leds/models/luzModel.dart';
import 'package:leds/provider/postRequests.dart';
import 'package:leds/widgets/colorToPick.dart';

class DialogWidget extends StatefulWidget {
  final Luz luzEffect;

  DialogWidget({@required this.luzEffect});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final ServerProvider serverProvider = new ServerProvider();
  Colores colores = Colores();

  @override
  Widget build(BuildContext context) {
    return widget.luzEffect.colorPicker
        ? _dialogWithPicker()
        : _dialogWithoutPicker();
  }

  Widget _dialogWithPicker() {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(0.0),
      content: ColorPicker(
        pickerColor: colores.pickerColor,
        onColorChanged: changeColor,
        enableAlpha: false,
        showLabel: false,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Cambiar Color'),
          onPressed: () {
            serverProvider.changeState({
              'state': '${widget.luzEffect.name.replaceAll(' ', '')}',
              'red': '${colores.red}',
              'green': '${colores.green}',
              'blue': '${colores.blue}'
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void changeColor(Color color) {
    colores.pickerColor = color;
    colores.red = color.red;
    colores.green = color.green;
    colores.blue = color.blue;
  }

  Widget _dialogWithoutPicker() {
    return AlertDialog(
      title: Text('Cambiar estado'),
      content: Text(
          '¿Está seguro que desea cambiar el modo a ${widget.luzEffect.name}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Cambiar Modo'),
          onPressed: () {
            serverProvider.changeState(
                {'state': '${widget.luzEffect.name.replaceAll(' ', '')}'});
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
