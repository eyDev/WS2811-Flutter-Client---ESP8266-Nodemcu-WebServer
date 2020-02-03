import 'package:flutter/material.dart';

import 'dialogs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Luces led'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () => botonTarjetas.cambiarEstadoDialog(context, 6),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return _listaBotones(context, ancho);
      }),
    );
  }

  Widget _listaBotones(BuildContext context, double ancho) {
    double bodyHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight;
    final botonList = Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                  ],
                ),
              ),
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                child: Text('Rainbow'),
                textColor: Colors.white,
                onPressed: () => botonTarjetas.cambiarEstadoDialog(context, 2),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
            Container(
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                child: Text('Color Puro'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => botonTarjetas.colorPuroDialog(context),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff304ffe), Colors.white],
                ),
              ),
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                child: Text('Fade'),
                textColor: Colors.white,
                onPressed: () => botonTarjetas.cambiarEstadoDialog(context, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      height: bodyHeight / 15,
                      width: ancho / 2,
                    ),
                    Container(
                      color: Colors.yellow,
                      height: bodyHeight / 15,
                      width: ancho / 2,
                    ),
                    Container(
                      child: Center(
                        child: Text('Color Wipe'),
                      ),
                      color: Colors.green,
                      height: bodyHeight / 15,
                      width: ancho / 2,
                    ),
                    Container(
                      color: Colors.purple,
                      height: bodyHeight / 15,
                      width: ancho / 2,
                    ),
                    Container(
                      color: Colors.blue,
                      height: bodyHeight / 15,
                      width: ancho / 2,
                    ),
                  ],
                ),
                textColor: Colors.white,
                onPressed: () => botonTarjetas.cambiarEstadoDialog(context, 3),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xffff8100),
                    Color(0xfff25500),
                    Color(0xffea2300),
                    Color(0xffd80000),
                    Color(0xffa10000),
                  ],
                ),
              ),
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                child: Text('Fire'),
                textColor: Colors.white,
                onPressed: () => botonTarjetas.rgbFire(context, 4),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
            Container(
              height: bodyHeight / 3,
              width: ancho / 2,
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.indigo,
                        height: bodyHeight / 9,
                        width: ancho / 2 - 30,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Side Fill'),
                      ),
                      height: bodyHeight / 9,
                      width: ancho / 2,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        color: Colors.indigo,
                        height: bodyHeight / 9,
                        width: ancho / 2 - 30,
                      ),
                    ),
                  ],
                ),
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () => botonTarjetas.rgbFire(context, 5),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black, width: 0.2)),
              ),
            ),
          ],
        ),
      ],
    );
    return botonList;
  }
}
