import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leds/models/luzModel.dart';
import 'package:leds/provider/postRequests.dart';
import 'package:leds/widgets/colorToPick.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return widget.luzEffect.colorPicker ? _dialogWithPicker() : _dialogWithoutPicker();
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
          child: Text('cancell'.tr()),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('changeColor'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
            EasyLoading.show(status: 'loading'.tr(), maskType: EasyLoadingMaskType.black);
            serverProvider.changeState({
              'state': '${widget.luzEffect.name.replaceAll(' ', '')}',
              'red': '${colores.red}',
              'green': '${colores.green}',
              'blue': '${colores.blue}'
            }).then((value) {
              EasyLoading.dismiss();
              value == 'Changed' ? EasyLoading.showSuccess('changed'.tr()) : EasyLoading.showError('error'.tr());
            });
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
      title: Text('changeState'.tr()),
      content: Text('changeStateDescription'.tr() + '${widget.luzEffect.name}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('cancell'.tr()),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('changeMode'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
            EasyLoading.show(
              status: 'loading'.tr(),
              maskType: EasyLoadingMaskType.black,
            );
            serverProvider.changeState({'state': '${widget.luzEffect.name.replaceAll(' ', '')}'}).then((value) {
              EasyLoading.dismiss();
              value == 'Changed' ? EasyLoading.showSuccess('changed'.tr()) : EasyLoading.showError('error'.tr());
            });
          },
        ),
      ],
    );
  }
}
