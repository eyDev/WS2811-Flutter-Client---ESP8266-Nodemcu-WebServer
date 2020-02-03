import 'package:flutter/material.dart';
import 'package:leds/src/request.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class _BottonTarjetas {
  String _modo = "";
  int _red, _green, _blue;
  Color _pickerColor = Colors.blue;
  String _urlToSend = "";

  void changeColor(Color color) {
    _pickerColor = color;
    _red = color.red;
    _green = color.green;
    _blue = color.blue;
  }

  void setURL(state) {
    _urlToSend = "$state&redF=$_red&greenF=$_green&blueF=$_blue";
  }

  void colorPuroDialog(BuildContext context) {
    _red = _pickerColor.red;
    _green = _pickerColor.green;
    _blue = _pickerColor.blue;
    showDialog(
      context: context,
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.all(0.0),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: changeColor,
            enableAlpha: false,
            enableLabel: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Cambiar Color'),
            onPressed: () {
              colorProvider.colorPuro(_red, _green, _blue);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void cambiarEstadoDialog(BuildContext context, int estado) {
    switch (estado) {
      case 1:
        _modo = "FADE";
        break;
      case 2:
        _modo = "RAINBOW";
        break;
      case 3:
        _modo = "COLOR WIPE";
        break;
      case 5:
        _modo = "EN PROCESO";
        break;
      case 6:
        _modo = "APAGAR";
        break;
    }
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Cambiar estado'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Está seguro que desea cambiar el modo a $_modo?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Cambiar Modo'),
            onPressed: () {
              colorProvider.cambiarModo(estado);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void rgbFire(BuildContext context, int state) {
    _red = _pickerColor.red;
    _green = _pickerColor.green;
    _blue = _pickerColor.blue;
    showDialog(
      context: context,
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.all(0.0),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: changeColor,
            enableAlpha: false,
            enableLabel: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Cambiar Estilo'),
            onPressed: () {
              setURL(state);
              colorProvider.cambiarModo(_urlToSend);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

final botonTarjetas = new _BottonTarjetas();
