import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

class IPaddressBloc extends Validator {
  final _ipController = StreamController<String>.broadcast();

  Stream<String> get ipStream => _ipController.stream.transform(validarIPaddress);

  Function(String) get changeip => _ipController.sink.add;

  dispose() {
    _ipController?.close();
  }
}

class Validator {
  final validarIPaddress = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern = r'^(([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('ipSinkError'.tr());
    }
  });
}
