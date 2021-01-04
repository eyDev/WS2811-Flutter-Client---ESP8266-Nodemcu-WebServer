import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final dynamic tstream;
  final dynamic tonChanged;
  final TextInputType type;

  const CustomInputField({
    @required this.label,
    @required this.prefixIcon,
    @required this.tstream,
    @required this.tonChanged,
    @required this.type,
  })  : assert(label != null),
        assert(prefixIcon != null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tstream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: type,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12), width: 1.0)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.12), width: 1.0)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.0)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.0)),
              labelText: label,
              errorText: snapshot.error,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1.color),
              prefixIcon: Icon(
                prefixIcon,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            onChanged: tonChanged,
          ),
        );
      },
    );
  }
}
